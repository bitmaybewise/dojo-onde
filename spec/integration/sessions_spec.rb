# encoding: UTF-8
require 'spec_helper'

describe Sessions do
  def setup
    @user = FactoryGirl.create :user
  end

  def teardown
    super
    @user = nil
  end

  it 'should login' do
    login @user
    assert find("div#welcome").has_content?("Bem vindo #{@user.name}")
  end

  it 'should back to homepage' do
    visit new_sessions_path
    click_on 'Voltar'
    assert_equal root_path, current_path, "Should be the homepage"
  end

  it 'should login fail with invalid user' do
    user = FactoryGirl.build(:user, email: 'malandro@ieie.com')
    login user
    assert find(".alert")
          .has_content?("Dados inválidos!"), 
          "E-mail and password should be valid"
  end

  it 'should logout' do
    login @user
    click_on 'Sair'
    assert find('div#welcome').has_content?('Acesse ou Registre-se'), 'Should not be logged'
  end

end
