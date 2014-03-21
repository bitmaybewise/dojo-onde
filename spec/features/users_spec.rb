require 'spec_helper'

feature "record of users" do
  let(:user) { FactoryGirl.create(:user) }

  scenario "should be created" do
    user = FactoryGirl.build(:user)
    insert user
    expect(page).to have_content "Bem vindo #{user.name}"
  end

  scenario "should be logged to edit" do
    visit edit_user_path(user)
    expect(current_path).to eql(login_path)
  end

  context "with user logged" do
    background { login user }

    scenario "should be edited" do
      new_name = "Homer Simpson"
      visit edit_user_path(user)
      click_on user.name
      fill_in  "Nome", with: new_name
      click_on "Salvar"
      expect(find "p.alert").to have_content "Usuário alterado com sucesso."
    end
    
    scenario "should change password" do
      new_password = "abc123"
      visit edit_user_path(user)
      click_on "Trocar senha"
      fill_in  "Senha",       with: new_password
      fill_in  "Confirmação", with: new_password
      click_on "Salvar"
      expect(page).to have_content "Senha alterada com sucesso"
    end

    scenario "shouldn't edit info of other user" do
      other = FactoryGirl.create(:user, email: "malandro@ieie.com")
      visit edit_user_path(other)
      expect(find("#user_email").value).to eql(user.email)
    end

    context "your dojo" do
      background { FactoryGirl.create(:dojo, user: user) }

      scenario "should be edited" do
        visit edit_user_path(user)
        find("table tbody tr:first").click_on("Editar")
        fill_in  "Local", with: "iéié"
        click_on "Salvar"
        expect(find "p.alert").to have_content "Dojo alterado com sucesso."
      end

      scenario "should be removed" do
        visit edit_user_path(user)
        find("table tbody tr:first").click_on("Excluir")
        expect(find "p.alert").to have_content "Dojo excluído com sucesso."
      end
    end
  end

  private
  def insert(user)
    visit new_user_path
    fill_in  "Nome",   with: user.name
    fill_in  "E-mail", with: user.email
    fill_in  "user_password",  with: user.password
    fill_in  "Confirmação de Senha", with: user.password_confirmation
    click_on "Salvar"
  end
end
