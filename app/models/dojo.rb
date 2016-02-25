class Dojo < ActiveRecord::Base
  belongs_to :user
  has_one :retrospective, dependent: :delete
  has_many :participants

  validates_presence_of :day, :local, :gmaps_link, :user
  validate :day_cannot_be_in_the_past, on: :create

  scope :happened,      -> { where("day <  ? ", Date.today).order("day DESC") }
  scope :not_happened,  -> { where("day >= ? ", Date.today).order("day ASC")  }
  scope :publishable,   -> { where(private: false) }

  before_create :add_creator_of_the_dojo_as_a_participant

  def to_s
    I18n.t("dojos.to_s.private_#{self.private?}", day_formatted: I18n.l(day), local: local)
  end

  def include_participant!(participant)
    self.participants.create(user_id: participant.id)
  end

  def remove_participant!(participant)
    self.participants.each { |p| p.destroy if p.user == participant }
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
