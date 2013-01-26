require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  test "should back to homepage" do
    visit new_user_path
    click_on "Cancelar"
    assert_equal current_path, root_path, "Should be homepage"
  end

  test "should create user" do
    user = FactoryGirl.build :user
    visit new_user_path
    fill_in "Nome",   with: user.name
    fill_in "E-mail", with: user.email
    fill_in "Senha",  with: user.password
    click_on "Salvar"
    assert page.has_content?("Bem vindo #{user.name}"), "Should create and login"
  end
end
