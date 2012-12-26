require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest

  test 'should navigate to homepage' do
    visit root_url
    within('h1') do
      assert has_content?('Dojo, aonde?'), 'Should be homepage'
    end
  end

  test 'should navigate to new dojo page' do
    visit root_url
    click_link('Novo dojo')
    within('h2') do
      assert has_content?('Novo dojo'), 'Should be dojo new page'
    end
  end

  test 'should show dojos list' do
    dojos = FactoryGirl.create_list(:dojo, 10)
    dojos.delete_if { |dojo| dojo.day < Date.today }

    visit root_url
    within('ul#dojos li:first') do
      assert has_content?(dojos.first.local)
    end
    within('ul#dojos li:last') do
      assert has_content?(dojos.last.local)
    end
  end

end
