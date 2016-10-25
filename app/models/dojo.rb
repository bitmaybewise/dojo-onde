class Dojo < ActiveRecord::Base
  belongs_to :user
  has_one :retrospective, dependent: :delete
  has_many :participants, dependent: :destroy

  validates_presence_of :day, :local, :gmaps_link, :user
  validate :day_cannot_be_in_the_past, on: :create
  validates :participant_limit, numericality: { only_integer: true }

  scope :happened,      -> { where("day <  ? ", Date.today).order("day DESC") }
  scope :not_happened,  -> { where("day >= ? ", Date.today).order("day ASC")  }
  scope :publishable,   -> { where(private: false) }

  before_create :add_creator_of_the_dojo_as_a_participant

  def to_param
    [id, local.parameterize].join("-")
  end

  def to_s
    I18n.t("dojos.to_s.private_#{self.private?}", day_formatted: I18n.l(day), local: local)
  end

  def include_participant!(user)
    raise Dojoonde::ParticipantLimitError if reached_limit?

    participants.create(user_id: user.id)
  end

  def remove_participant!(user)
    if participant = participants.find_by(user_id: user)
      participants.destroy(participant)
    end
  end

  def has_limit?
    participant_limit > 0
  end

  def reached_limit?
    has_limit? && participants.size >= participant_limit
  end

  def has_participant?(participant)
    return false unless participant

    participants.find_by(user_id: participant).present?
  end

  def belongs_to?(_user)
    user == _user
  end

  private
  def day_cannot_be_in_the_past
    errors.add(:day, :cannot_be_in_the_past) if day.present? && day < Date.today
  end

  def add_creator_of_the_dojo_as_a_participant
    unless self.user.participate?(self)
      self.participants.build(user_id: user.id)
    end
  end
end
