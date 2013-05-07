# encoding: UTF-8

class Dojo < ActiveRecord::Base
  belongs_to :user
  has_one :retrospective, dependent: :delete
  attr_accessible :day, :local, :info, :gmaps_link, :user_id, :user

  validates_presence_of :day
  validates_presence_of :local
  validates_presence_of :gmaps_link
  validate :day_cannot_be_in_the_past, on: :create

  def self.happened
    where("day < ? ", Date.today).order("day DESC")
  end

  def self.not_happened
    where("day >= ? ", Date.today).order("day ASC")
  end

  def to_s
    "#{day.strftime("%d-%m-%Y %H:%M\h")} - #{local}"
  end

  private
  def day_cannot_be_in_the_past
    if !day.blank? && day < Date.today
      errors.add(:day, "anterior não é permitido")
    end
  end
end
