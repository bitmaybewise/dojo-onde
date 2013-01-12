# encoding: UTF-8

class Dojo < ActiveRecord::Base
  attr_accessible :local, :day, :limit_people, :address, :city, :info, :gmaps_link

  validates :local,   :presence => { message: "local é obrigatório" }
  validates :address, :presence => { message: "endereço é obrigatório" }
  validates :city,    :presence => { message: "cidade é obrigatória" }
  validates :day,     :presence => { message: "dia é obrigatório" }
  validate  :day_cannot_be_in_the_past

  private
  def day_cannot_be_in_the_past
    if !day.blank? and day < Date.today
      errors.add(:day, "dias anteriores não são permitidos")
    end
  end
end
