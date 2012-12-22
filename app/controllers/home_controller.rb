class HomeController < ApplicationController
  def index
    @dojos = Dojo.all
  end
end
