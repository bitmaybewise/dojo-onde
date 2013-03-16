# encoding: UTF-8
require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryGirl.create(:user)
  end
  def teardown
    super
    @user = nil
  end

  test "should back to homepage" do
    visit new_user_path
    click_on "Cancelar"
    assert_equal current_path, root_path, "Should be homepage"
  end

  test "should insert" do
    user = FactoryGirl.build(:user, email: "teste@dojoaonde.com")
    insert user
    assert page.has_content?("Bem vindo #{user.name}"), "Should create and login"
  end

  test "should edit" do
    new_name = "#{@user.name} alterado"
    visit root_path
    with @user do
      click_on "#{@user.name}"
      fill_in "Nome", with: new_name
      click_on "Salvar"
      assert_equal root_path, current_path
    end
  end

  test "should change password" do
    new_password = "abc123"
    with @user do
      visit edit_user_path(@user)
      click_on("Trocar senha")
      fill_in("Senha nova", with: new_password)
      fill_in("Confirmação de senha", with: new_password)
      click_on("Salvar")
      assert page.has_content?("Senha alterada com sucesso")
    end
  end

  test "should be logged to edit" do
    visit edit_user_path(@user)
    assert_equal login_path, current_path, "Should be login page"
  end

  test "should not edit info of other user" do
    user1 = FactoryGirl.create(:user, email: "teste1@dojoaonde.com.br")
    user2 = FactoryGirl.create(:user, email: "teste2@dojoaonde.com.br")
    with user1 do
      visit edit_user_path(user2)
      user_email = find("#user_email").value
      assert_equal user1.email, user_email, "Should load page with logged user"
    end
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
    assert_invalid @user, "e-mail já registrado"
  end

  test "should require password" do
    user = FactoryGirl.build(:user, password: nil)
    assert_invalid user, "senha é obrigatória"
  end

  test "should be 6 or more caracters to password" do
    user = FactoryGirl.build(:user, password: "123")
    assert_invalid user, "senha deve ter no mínimo 6 caracteres"
  end

  test "should be required password confirmation" do
    user = FactoryGirl.build(:user, password_confirmation: "iéié")
    assert_invalid user, "confirmação não bate"
  end

  private
  def assert_invalid(user, msg="")
    insert user
    assert find("div#error_explanation")
          .has_content?(msg), "Should show \"#{msg}\""
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
