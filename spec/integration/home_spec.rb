# encoding: utf-8
require 'spec_helper'

describe Home do
  def setup
    @user = FactoryGirl.create(:user)
    20.times { FactoryGirl.create(:dojo) }
  end

  def teardown
    super
    @user = nil
  end

  it 'should visit homepage' do
    visit root_path
    assert find('h1').has_content?('Dojo, onde?'), 'Should be homepage'
    assert_equal current_path, root_path, "Current path should be equal root path"
  end

  it 'should visit page of dojos that happened' do
    visit root_url
    click_link('Já aconteceram')
    assert find('h2').has_content?('Dojos que já aconteceram'), 'Should be dojos that happened page'
  end

  it 'should visit new dojo page' do
    with @user do
      visit root_path
      click_on('Novo')
      assert find('h2').has_content?('Novo dojo'), 'Should be new dojo page'
    end
  end

  it 'should visit dojos page' do
    visit root_path
    click_on("Exibir todos")
    assert find("h2").has_content?("Próximos dojos"), "Should show list page"
  end

  it 'should visit login page' do
    visit root_path
    click_link("Acesse")
    assert find("h2").has_content?("Login"), "Should be login page"
  end

  it 'should login' do
    login @user
    assert page.has_content?("Bem vindo #{@user.name}")
  end

  it 'should logout' do
    login @user
    logout
    assert page.has_no_content?("Bem vindo #{@user.name}")
  end

  it 'should visit signup page' do
    visit root_path
    click_on 'Registre-se'
    assert find('h2').has_content?('Registrar-se'), 'Should be signup page'
  end

end
