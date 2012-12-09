require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test 'should get homepage' do
    get :index
    assert_select "h1", "Dojo, aonde?"
  end
end
