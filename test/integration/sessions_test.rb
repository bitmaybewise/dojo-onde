# encoding: UTF-8
require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryGirl.create :user
  end

  def teardown
    super
    @user = nil
  end

  test 'should login' do
    login @user
    assert find("div#welcome").has_content?("Bem vindo #{@user.name}")
  end

  test 'should back to homepage' do
    visit new_sessions_path
    click_on 'Voltar'
    assert_equal root_path, current_path, "Should be the homepage"
  end

  test 'should login fail with invalid user' do
    user = FactoryGirl.build(:user, email: 'malandro@ieie.com')
    login user
    assert find(".alert").has_content?("E-mail ou senha inválida!"), "E-mail and password should be valid"
  end

  test 'should logout' do
    login @user
    click_on 'Sair'
    assert find('div#welcome').has_content?('Acesse ou Registre-se'), 'Should not be logged'
  end

end
