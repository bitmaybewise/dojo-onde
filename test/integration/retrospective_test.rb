require 'test_helper'

class RetrospectiveTest < ActionDispatch::IntegrationTest
  test "should create retrospective" do
    dojo = FactoryGirl.create(:dojo)
    retro = FactoryGirl.build(:retrospective)
    with dojo.user do
      visit edit_dojo_path(dojo)
      click_on "Registrar retrospectiva"
      fill_in  "Desafio", with: retro.challenge
      fill_in  "Pontos Positivos", with: retro.positive_points
      fill_in  "Pontos de Melhoria", with: retro.improvement_points
      click_on "Salvar"
      assert find("p.alert").has_content?("Retrospectiva registrada.")
    end
  end

  test "should show retrospective" do
    retro = FactoryGirl.create(:retrospective)
    visit dojo_path(retro.dojo)
    assert page.has_content?("Retrospectiva"), "should show title"
    assert page.has_content?("Desafio"), "should show challenge"
    assert page.has_content?(retro.challenge)
    assert page.has_content?("Pontos Positivos"), "should show positive points"
    assert page.has_content?(retro.positive_points)
    assert page.has_content?("Pontos de Melhoria"), "should show improvement points"
    assert page.has_content?(retro.improvement_points)
  end

  test "should edit retrospective" do
    retro = FactoryGirl.create(:retrospective)
    with retro.dojo.user do
      visit edit_dojo_path(retro.dojo)
      click_on "Editar retrospectiva"
      fill_in  "Pontos Positivos", with: "Aprendizado"
      fill_in  "Pontos de Melhoria", with: "Sem internet"
      click_on "Salvar"
      assert find("p.alert").has_content?("Retrospectiva atualizada.")
    end
  end

  test "should require login to insert" do
    dojo = FactoryGirl.create(:dojo)
    visit new_dojo_retrospective_path(dojo)
    assert_equal login_path, current_path
    assert find('h2').has_content?('Login'), 'should be login page'
  end
end
