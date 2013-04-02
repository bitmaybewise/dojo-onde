# encoding: UTF-8

class Dojo < ActiveRecord::Base
  belongs_to :user
  attr_accessible :day, :local, :info, :gmaps_link, :user_id, :user

  validates_presence_of :day
  validates_presence_of :local
  validates_presence_of :gmaps_link
  validate  :day_cannot_be_in_the_past

  def self.happened
    where("day < ? ", Date.today).order("day DESC")
  end

  def self.not_happened
    where("day >= ? ", Date.today).order("day ASC")
  end

  def local=(value)
    value.capitalize! unless value.nil?
    write_attribute(:local, value)
  end

  def to_s
    "#{day.strftime("%d-%m-%Y %H:%M\h")} - #{local.capitalize}"
  end

  private
  def day_cannot_be_in_the_past
    if !day.blank? and day < Date.today
      errors.add(:day, "anterior não é permitido")
    end
  end
end
