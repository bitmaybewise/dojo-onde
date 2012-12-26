class Dojo < ActiveRecord::Base
  attr_accessible :local, :day, :limit_people, :info, :city, :gmaps_link

  validates_presence_of :local, :day, :city
end
