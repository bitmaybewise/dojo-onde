require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  test 'should get homepage' do
    visit root_url
    within('h1') do
      assert has_content?('Dojo, aonde?')
    end
  end
end
