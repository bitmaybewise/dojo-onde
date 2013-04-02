class HomeController < ApplicationController
  def index
    @dojos = Dojo.not_happened.limit(10)
  end
end
