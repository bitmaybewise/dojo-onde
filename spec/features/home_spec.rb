# encoding: utf-8
require 'spec_helper'

feature "homepage" do
  before(:each, with_dojos: true) do
    10.times { FactoryGirl.create(:dojo) }
  end
  let(:user) { FactoryGirl.create(:user) }

  background { visit root_path }

  context "without logging" do
    scenario "should visit page of dojos that happened" do
      click_on "Já aconteceram"
      expect(find "h2").to have_content "Dojos que já aconteceram"
    end

    scenario "should visit dojos page", with_dojos: true do
      click_on "Exibir todos"
      expect(find "h2").to have_content "Próximos dojos"
    end

    scenario "should visit login page" do
      click_on "Acesse"
      expect(find "h2").to have_content "Login"
    end

    scenario "should login" do
      login user
      expect(page).to have_content "Bem vindo #{user.name}"
    end

    scenario "should visit signup page" do
      click_on "Registre-se"
      expect(find "h2").to have_content "Registrar-se"
    end
  end

  context "with user logged" do
    background { login user }

    scenario "should visit new dojo page" do
      click_on "Novo"
      expect(find "h2").to have_content "Novo dojo"
    end

    scenario "should logout" do
      logout
      expect(page).not_to have_content "Bem vindo #{user.name}"
    end
  end
end