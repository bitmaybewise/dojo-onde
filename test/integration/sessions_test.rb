# encoding: UTF-8
require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  test 'should log in' do
    user = FactoryGirl.create :user
    login user
    assert find("div#welcome").has_content?("Bem vindo #{user.name}!")
  end

  test 'should back to homepage' do
    visit new_sessions_path
    click_on 'Voltar'
    assert_equal root_path, current_path, "Should be the homepage"
  end

  test 'should login fail with invalid user' do
    user = FactoryGirl.build :user
    login user
    assert find("div.alert").has_content?("E-mail ou senha inválida!"), "E-mail and password should be valid"
  end

  test 'should log out' do
    user = FactoryGirl.create :user
    login user
    click_on 'Sair'
    assert find('div#welcome').has_content?('Acesse ou Registre-se'), 'Should not be logged'
  end

  private
  def login(user)
    visit new_sessions_path
    fill_in "E-mail", with: user.email
    fill_in "Senha",   with: user.password
    click_on "Acessar"
  end
end
