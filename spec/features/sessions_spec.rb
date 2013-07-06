# encoding: UTF-8
require 'spec_helper'

feature "sessions" do
  scenario "login page should back to homepage" do
    visit new_sessions_path
    click_on "Voltar"
    expect(root_path).to eql(current_path)
  end

  context "with valid user" do
    let(:user) { FactoryGirl.create(:user) }
    background { login user }

    scenario "should login" do
      expect(page).to have_content "Bem vindo #{user.name}"
    end

    scenario "should logout" do
      click_on "Sair"
      expect(find "div#welcome").to have_content "Acesse ou Registre-se"
    end
  end

  context "with invalid user" do
    let(:user) { FactoryGirl.build(:user, email: "malandro@ieie.com") }

    scenario "login should fail" do
      login user
      expect(find ".alert").to have_content "Dados inválidos"
    end
  end
end
