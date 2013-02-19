class HomeController < ApplicationController
  def index
    @dojos = Dojo.not_happened
  end
end
