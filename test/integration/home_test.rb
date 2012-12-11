require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  test 'should navigate to homepage' do
    visit root_url
    within('h1') do
      assert has_content?('Dojo, aonde?')
    end
  end

  test 'should navigate to new dojo page' do
    visit root_url
    click_link('Novo dojo')
    within('h2') do
      assert has_content? 'Novo dojo'
    end
  end
end
