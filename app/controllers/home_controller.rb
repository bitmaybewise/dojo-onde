class HomeController < ApplicationController
  def index
    @dojos = Dojo.not_happened.limit(5)
  end
end
