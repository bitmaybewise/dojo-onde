require 'spec_helper'

feature "record of dojos" do
  let(:dojo) { FactoryGirl.create(:dojo) }

  scenario "should be displayed" do
    visit dojo_path(dojo)
    expect(find "h2").to have_content dojo
    expect(page).to      have_content dojo.user.name
    expect(page).to      have_content dojo.info
  end

  context "should require login" do
    scenario "to insert" do
      visit new_dojo_path
      expect(current_path).to eq login_path
    end

    scenario "to edit" do
      visit edit_dojo_path(dojo)
      expect(current_path).to eq login_path
    end

    scenario "to participate" do
      visit dojo_path(dojo)
      click_on "Eu vou!"
      expect(current_path).to eq login_path
    end
  end

  context "with user logged" do
    let(:user) { FactoryGirl.create(:user) }
    background { login user }

    scenario "should be inserted" do
      insert dojo
      expect(find "h2").to have_content dojo
    end

    scenario "should be edited" do
      other = "Casa da mãe Joana"
      visit edit_dojo_path(dojo)
      fill_in  "Local", with: other
      click_on "Salvar"
      expect(find "p.alert").to have_content "Dojo alterado com sucesso."
    end

    scenario "should cancel insertion" do
      visit new_dojo_path
      click_on "Cancelar"
      expect(current_path).to eql(root_path)
    end

    scenario "should cancel edition" do
      visit edit_dojo_path(dojo)
      click_on "Cancelar"
      expect(current_path).to eql(root_path)
    end

    scenario "should create copied" do
      visit edit_dojo_path(dojo)
      click_on "Copiar"
      expect(find "#dojo_day").to have_content ""
    end
  end

  private
  def insert(dojo)
    visit new_dojo_path
    fill_in "Dia",   with: dojo.day
    fill_in "Local", with: dojo.local
    fill_in "Link do Google Maps", with: dojo.gmaps_link
    fill_in "Outras Informações",  with: dojo.info
    click_button "Salvar"
  end
end
