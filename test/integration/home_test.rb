# encoding: utf-8
require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryGirl.create :user
  end

  def teardown
    super
    @user = nil
  end

  test 'should visit homepage' do
    visit root_path
    assert find('h1').has_content?('Dojo, aonde?'), 'Should be homepage'
    assert_equal current_path, root_path, "Current path should be equal root path"
  end

  test 'should visit page of dojos that happened' do
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

  test 'should visit new dojo page' do
    login(@user)
    visit root_path
    click_link('Novo dojo')
    assert find('h2').has_content?('Novo dojo'), 'Should be new dojo page'
  end

  test 'should visit dojos page' do
    visit root_path
    click_link("Exibir todos")
    assert find("h2").has_content?("Dojos cadastrados"), "Should show list page"
  end

  test 'should visit login page' do
    visit root_path
    click_link("Acesse")
    assert find("h2").has_content?("Login"), "Should be login page"
  end

  test 'should login' do
    login @user
    assert page.has_content?("Bem vindo #{@user.name}")
  end

  test 'should logout' do
    login @user
    logout
    assert page.has_no_content?("Bem vindo #{@user.name}")
  end

  test 'should visit signup page' do
    visit root_path
    click_on 'Registre-se'
    assert find('h2').has_content?('Registrar-se'), 'Should be signup page'
  end

end
