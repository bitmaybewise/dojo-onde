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

    context "should be invalid" do
      let(:user) { FactoryGirl.build(:user) }

      scenario "without a name" do
        user.name = nil
        should_be_invalid_with user, "Nome não pode ficar em branco"
      end

      scenario "without an email" do
        user.email = nil
        should_be_invalid_with user, "E-mail não pode ficar em branco"
      end

      scenario "with an invalid email" do
        user.email = "ieie.com"
        should_be_invalid_with user, "E-mail não é válido"
      end

      scenario "with an invalid email" do
        other = create(:user)
        user.email = other.email
        should_be_invalid_with user, "E-mail já está em uso"
      end

      scenario "without a password" do
        user = build(:user, password: nil)
        user.password = nil
        should_be_invalid_with user, "Senha é muito curta (mínimo: 6 caracteres)"
      end

      scenario "with less than 6 caracters to password" do
        user.password = "123"
        should_be_invalid_with user, "Senha é muito curta (mínimo: 6 caracteres)"
      end

      scenario "without password confirmation" do
        user.email = generate(:email)
        user.password_confirmation = nil
        should_be_invalid_with user, "Confirmação não confere"
      end
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

  def should_be_invalid_with(user, msg)
    insert user
    expect(find "div.alert").to have_content msg
  end
end
