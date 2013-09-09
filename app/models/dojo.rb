# encoding: UTF-8

class Dojo < ActiveRecord::Base
  belongs_to :user
  has_one :retrospective, dependent: :delete
  has_many :participants

  attr_accessible :day, :local, :info, :gmaps_link, :user_id, :user

  validates_presence_of :day
  validates_presence_of :local
  validates_presence_of :gmaps_link
  validate :day_cannot_be_in_the_past, on: :create

  scope :happened,     -> { where("day <  ? ", Date.today).order("day DESC") }
  scope :not_happened, -> { where("day >= ? ", Date.today).order("day ASC")  }

  def to_s
    "#{day.strftime("%d-%m-%Y %H:%M\h")} - #{local}"
  end

  def save(*)
    self.participants.build(user_id: user.id) unless self.user.participate?(self)
    super
  end

  def include_participant!(participant)
    self.participants.create(user_id: participant.id)
  end

  def remove_participant!(participant)
    self.participants.each { |p| p.destroy if p.user == participant }
  end

  private
    def day_cannot_be_in_the_past
      errors.add(:day, "anterior não é permitido") if day.present? && day < Date.today
    end
end
