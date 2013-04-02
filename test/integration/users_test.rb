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
    with @user do
      visit edit_user_path(@user)
      click_on "#{@user.name}"
      fill_in "Nome", with: new_name
      click_on "Salvar"
      assert find("p.alert").has_content?("Usuário alterado com sucesso.")
    end
  end

  test "should change password" do
    new_password = "abc123"
    with @user do
      visit edit_user_path(@user)
      click_on("Trocar senha")
      fill_in("Senha", with: new_password)
      fill_in("Confirmação", with: new_password)
      click_on("Salvar")
      assert page.has_content?("Senha alterada com sucesso")
    end
  end

  test "should be logged to edit" do
    visit edit_user_path(@user)
    assert_equal login_path, current_path, "Should be login page"
  end

  test "shouldn't edit info of other user" do
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
    assert_invalid user, "Nome não pode ficar em branco"
  end

  test "should require email" do
    user = FactoryGirl.build(:user, email: nil)
    assert_invalid user, "E-mail não pode ficar em branco"
  end

  test "should require a valid email" do
    user = FactoryGirl.build(:user, email: "dojoaonde.com")
    assert_invalid user, "E-mail não é válido"
  end

  test "should require a unique email" do
    assert_invalid @user, "E-mail já está em uso"
  end

  test "should require password" do
    user = FactoryGirl.build(:user, password: nil)
    assert_invalid user, "Senha não pode ficar em branco"
  end

  test "should be 6 or more caracters to password" do
    user = FactoryGirl.build(:user, password: "123")
    assert_invalid user, "Senha é muito curta (mínimo: 6 caracteres)"
  end

  test "should be required password confirmation" do
    user = FactoryGirl.build(:user, password_confirmation: "iéié")
    assert_invalid user, "Senha não está de acordo com a confirmação"
  end

  test "should edit your dojo" do
    FactoryGirl.create(:dojo, user: @user)
    with @user do
      visit edit_user_path(@user)
      find("table tbody tr:first").click_on("Editar")
      fill_in("Local", with: "iéié")
      click_on("Salvar")
      assert find("p.alert").has_content?("Dojo alterado com sucesso.")
    end
  end

  test "shouldn't edit dojo that happened" do
    FactoryGirl.create(:dojo, day: Time.now - 5.days, user: @user)
    with @user do
      visit edit_user_path(@user)
      assert_false find("table tbody tr:first").has_content?("Editar"),
                   "Should be not show 'Editar' button"
    end
  end

  test "should remove my dojo" do
    FactoryGirl.create(:dojo, user: @user)
    with @user do
      visit edit_user_path(@user)
      find("table tbody tr:first").click_on("Excluir")
      assert find("p.alert").has_content?("Dojo excluído com sucesso.")
    end
  end

  private
  def assert_invalid(user, msg="")
    insert user
    assert find("div.alert").has_content?(msg), "Should show '#{msg}'"
  end

  def insert(user)
    visit new_user_path
    fill_in "Nome",   with: user.name
    fill_in "E-mail", with: user.email
    fill_in "user_password",  with: user.password
    fill_in "Confirmação de Senha", with: user.password_confirmation
    click_on "Salvar"
  end
end
