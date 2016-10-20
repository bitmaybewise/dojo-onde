# encoding: UTF-8
require 'spec_helper'

feature "participate of the dojo" do
  let(:user) { FactoryGirl.create(:user) }
  let(:dojo) { FactoryGirl.create(:dojo, user: user) }

  context "when user is not logged" do
    scenario "should display participate button on dojo page" do
      visit dojo_path(dojo)
      expect(page).to have_content "Eu vou!"
    end
  end

  context "when user that create the dojo is logged" do
    background do
      login user
      visit dojo_path(dojo)
    end

    scenario "should display 1 participant when dojo created" do
      expect(page).to have_content "1 pessoa marcou presença"
    end

    scenario "should display quit button for participant" do
      expect(page).not_to have_content "Eu vou!"
      expect(page).to have_content "Desistir :("
    end

    scenario "should quit of the dojo" do
      click_on "Desistir :("
      expect(current_path).to eq dojo_path(dojo)
      expect(page).to have_content "Eu vou!"
      expect(page).to have_content "Que pena que desistiu :("
      expect(page).to have_content "0 pessoas marcaram presença"
    end

    scenario "should participate of the dojo" do
      dojo.remove_participant!(dojo.user)
      visit dojo_path(dojo)

      click_on "Eu vou!"
      expect(current_path).to eq dojo_path(dojo)
      expect(page).to have_content "Desistir :("
      expect(page).to have_content "Incluído na lista de participantes ;)"
      expect(page).to have_content "1 pessoa marcou presença"
    end
  end

  context "when other user is logged" do
    let(:other) { FactoryGirl.create(:user, name: "Malandro", email: "ieie@dojoonde.com.br") }

    background do
      login other
      visit dojo_path(dojo)
    end

    scenario "should display participate button on dojo page" do
      expect(page).to have_content "Eu vou!"
    end

    scenario "should participate of the dojo" do
      click_on "Eu vou!"
      allow(user).to receive(:participate?).and_return(false)
      expect(current_path).to eq dojo_path(dojo)
      expect(page).to have_content "Desistir :("
      expect(page).to have_content "Incluído na lista de participantes ;)"
      expect(page).to have_content "2 pessoas marcaram presença"
    end

    scenario "should quit of the dojo" do
      dojo.include_participant!(other)
      visit dojo_path(dojo)

      click_on "Desistir :("
      expect(current_path).to eq dojo_path(dojo)
      expect(page).to have_content "Eu vou!"
      expect(page).to have_content "Que pena que desistiu :("
      expect(page).to have_content "1 pessoa marcou presença"
    end
  end
end
