# encoding: UTF-8

class Dojo < ActiveRecord::Base
  attr_accessible :day, :local, :limit_people, :info, :gmaps_link

  validates :day,   :presence => { message: "dia é obrigatório" }
  validates :local, :presence => { message: "local é obrigatório" }
  validate  :day_cannot_be_in_the_past

  def self.happened
    where("day < ? ", Date.today).order("day DESC")
  end

  def self.not_happened
    where("day >= ? ", Date.today).order("day ASC")
  end

  def local=(value)
    write_attribute(:local, value.capitalize)
  end

  def to_s
    "#{day.day}/#{day.month}/#{day.year} em #{local.capitalize}"
  end

  private
  def day_cannot_be_in_the_past
    if !day.blank? and day < Date.today
      errors.add(:day, "dias anteriores não são permitidos")
    end
  end
end
