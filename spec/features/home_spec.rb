# encoding: utf-8
require 'spec_helper'

feature "homepage" do
  before(:each, with_dojos: true) do
    10.times { FactoryGirl.create(:dojo) }
  end

  context "unauthenticated" do
    scenario "list only public dojos" do
      public_dojo  = FactoryGirl.create(:dojo, 
                                          private: false, 
                                          local: 'publico',
                                          day: 2.days.from_now)
      private_dojo = FactoryGirl.create(:dojo, 
                                          private: true, 
                                          local: 'privado',
                                          day: 3.days.from_now)
      visit root_path
      expect(page).to have_content public_dojo.local
      expect(page).not_to have_content private_dojo.local
    end

    scenario "visit page of dojos that happened" do
      public_dojo  = FactoryGirl.create(:dojo, 
                                          private: false, 
                                          local: 'publico',
                                          day: 2.days.ago)
      private_dojo = FactoryGirl.create(:dojo, 
                                          private: true, 
                                          local: 'privado',
                                          day: 3.days.ago)
      visit root_path
      click_on "Já aconteceram"
      expect(find "h2").to have_content "Dojos que já aconteceram"
      expect(page).to have_content public_dojo.local
      expect(page).to have_content private_dojo.local
    end

    scenario "visit dojos page", with_dojos: true do
      visit root_path
      click_on "Exibir todos"
      expect(find "h2").to have_content "Próximos dojos"
    end

    scenario "visit login page" do
      visit root_path
      click_on "Acesse"
      expect(find "h2").to have_content "Login"
    end

    scenario "visit signup page" do
      visit root_path
      click_on "Registre-se"
      expect(find "h2").to have_content "Registrar-se"
    end
  end

  context "authenticated" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "visit new dojo page" do
      login user
      click_on "Novo"
      expect(find "h2").to have_content "Novo dojo"
    end
  end
end
