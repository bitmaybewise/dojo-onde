class HomeController < ApplicationController
  def index
    @dojos = Dojo.publishable.not_happened.limit(5)
  end
end
