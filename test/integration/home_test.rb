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

  test 'should show dojos list' do
    10.times { FactoryGirl.create(:dojo) }
    visit root_url
    within('ul#dojos li:first') do
      assert has_content? 'Faculdade1'
    end
    within('ul#dojos li:last') do
      assert has_content? 'Faculdade10'
    end
  end

end
