# encoding: UTF-8
require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  test "should back to homepage" do
    visit new_user_path
    click_on "Cancelar"
    assert_equal current_path, root_path, "Should be homepage"
  end

  test "should create user" do
    user = FactoryGirl.build :user
    insert user
    assert page.has_content?("Bem vindo #{user.name}"), "Should create and login"
  end

  test "should require name" do
    user = FactoryGirl.build(:user, name: nil)
    assert_invalid user, "nome é obrigatório"
  end

  test "should require email" do
    user = FactoryGirl.build(:user, email: nil)
    assert_invalid user, "e-mail é obrigatório"
  end

  test "should require a valid email" do
    user = FactoryGirl.build(:user, email: "dojoaonde.com")
    assert_invalid user, "e-mail inválido"
  end

  test "should require a unique email" do
    user = FactoryGirl.create(:user)
    assert_invalid user, "e-mail já registrado"
  end

  test "should require password" do
    user = FactoryGirl.build(:user, password: nil)
    assert_invalid user, "senha é obrigatória"
  end

  test "should be 6 or more caracters to password" do
    user = FactoryGirl.build(:user, password: "123")
    assert_invalid user, "senha deve ter no mínimo 6 caracteres"
  end

  test "should require password confirmation" do
    user = FactoryGirl.build(:user, password_confirmation: nil)
    assert_invalid user, "confirme sua senha"
  end

  test "should be password confirmation equal password" do
    user = FactoryGirl.build(:user, password_confirmation: "iéié")
    assert_invalid user, "valor de confirmação difere da senha"
  end

  private
  def assert_invalid(user, msg="")
    insert user
    assert find("div#error_explanation").has_content?(msg),
      "Should show \"#{msg}\""
  end

  def insert(user)
    visit new_user_path
    fill_in "Nome",   with: user.name
    fill_in "E-mail", with: user.email
    fill_in "Senha",  with: user.password
    fill_in "Confirmação de senha", with: user.password_confirmation
    click_on "Salvar"
  end
end
