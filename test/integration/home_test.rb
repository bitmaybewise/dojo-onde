# encoding: utf-8
require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  test 'should navigate to homepage' do
    visit root_url
    assert find('h1').has_content?('Dojo, aonde?'), 'Should be homepage'
    assert_equal current_path, root_path, "Current path should be equal root path"
  end

  test 'should navigate to page of dojos that happened' do
    dojos = FactoryGirl.create_list(:dojo, 10)
    dojos.delete_if { |dojo| dojo.day > Date.today }
    visit root_url
    click_link('Já aconteceu!')
    assert find('h2').has_content?('Dojos que já aconteceram!'), 'Should be dojos that happened page'
  end

  test 'should show dojos list' do
    dojos = FactoryGirl.create_list(:dojo, 10)
    dojos.delete_if { |dojo| dojo.day < Date.today }
    visit root_url
    assert find('ul#dojos li:first').has_content?(dojos.first.local)
    assert find('ul#dojos li:last').has_content?(dojos.last.local)
  end

  test 'should navigate to new dojo page' do
    visit root_url
    click_link('Novo dojo')
    assert find('h2').has_content?('Novo dojo'), 'Should be new dojo page'
  end

  test 'should navigate to dojos page' do
    visit root_url
    click_link("Exibir todos")
    assert find("h2").has_content?("Dojos cadastrados"), "Should show list page"
  end

  test 'should go to login page' do
    visit root_url
    click_link("Acesse")
    assert find("h2").has_content?("Login"), "Should be login page"
  end
end
