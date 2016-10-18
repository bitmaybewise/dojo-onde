require 'spec_helper'

feature "dojo" do
  let(:dojo) { FactoryGirl.create(:dojo) }

  scenario "should be displayed" do
    visit dojo_path(dojo)
    expect(find "h2").to have_content dojo
    expect(page).to      have_content dojo.user.name
    expect(page).to      have_content dojo.info
  end

  scenario "should be listed when public and not happened" do
    public_dojo  = FactoryGirl.create(:dojo, private: false, local: 'publico')
    private_dojo = FactoryGirl.create(:dojo, private: true, local: 'privado')
    visit dojos_path
    expect(page).to have_content public_dojo.local
    expect(page).to_not have_content private_dojo.local
  end

  context "login required" do
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

  context "authenticated" do
    let(:user) { FactoryGirl.create(:user) }
    let(:dojo) { FactoryGirl.build(:dojo, user: user) }
    background { login user }

    scenario "should be inserted" do
      insert dojo
      expect(find "h2").to have_content dojo
    end

    scenario "should be edited" do
      dojo.save
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
      dojo.save
      visit edit_dojo_path(dojo)
      click_on "Cancelar"
      expect(current_path).to eql(root_path)
    end

    scenario "should create copied" do
      dojo.save
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
