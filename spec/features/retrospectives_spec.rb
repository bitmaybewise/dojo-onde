require 'spec_helper'

feature "record of retrospectives" do
  let(:retro) { FactoryGirl.create(:retrospective) }

  scenario "should be displayed" do
    visit dojo_path(retro.dojo)
    expect(page).to have_content "Retrospectiva"
    expect(page).to have_content "Desafio"
    expect(page).to have_content retro.challenge
    expect(page).to have_content "Pontos Positivos"
    expect(page).to have_content retro.positive_points
    expect(page).to have_content "Pontos de Melhoria"
    expect(page).to have_content retro.improvement_points
  end

  context "should require login" do
    scenario "to insert" do
      visit new_dojo_retrospective_path(retro.dojo)
      expect(current_path).to eql(login_path)
    end

    scenario "to edit" do
      visit edit_dojo_path(retro.dojo)
      expect(current_path).to eql(login_path)
    end
  end

  context "with user logged" do
    let(:user) { FactoryGirl.create(:user) }
    background { login user }
    
    scenario "should be created" do
      dojo  = FactoryGirl.create(:dojo)
      retro = FactoryGirl.build(:retrospective)

      visit edit_dojo_path(dojo)
      click_on "Registrar retrospectiva"
      fill_in  "Desafio",            with: retro.challenge
      fill_in  "Pontos Positivos",   with: retro.positive_points
      fill_in  "Pontos de Melhoria", with: retro.improvement_points
      click_on "Salvar"
      expect(find "p.alert").to have_content "Retrospectiva registrada."
    end

    scenario "should be edited" do
      visit edit_dojo_path(retro.dojo)
      click_on "Editar retrospectiva"
      fill_in  "Pontos Positivos",   with: "Aprendizado"
      fill_in  "Pontos de Melhoria", with: "Sem internet"
      click_on "Salvar"
      expect(find "p.alert").to have_content "Retrospectiva atualizada."
    end
  end
end
