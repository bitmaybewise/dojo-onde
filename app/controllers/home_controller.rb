class HomeController < ApplicationController
  def index
    @dojos = Dojo.where("day >= ? ", Date.today).order("day ASC")
  end
end
