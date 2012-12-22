require 'test_helper'

class DojosTest < ActionDispatch::IntegrationTest
  test 'should insert dojo' do
    visit root_url
    click_link('Novo dojo')
    fill_in('Local', with: 'Faculdade XPTO')
    click_button('Salvar')
    within('h2') do
      assert has_content? 'Dojo Faculdade XPTO'
    end
  end

  test 'should go to list page from edit page' do
    FactoryGirl.create(:dojo)
    visit '/dojos/1'
    click_link('Voltar')
    within('h2') do
      assert has_content? 'Dojos cadastrados'
    end
  end

  test 'should back to homepage' do
    visit '/dojos/new'
    click_link('Cancelar')
    within('h1') do
      assert has_content? 'Dojo, aonde?'
    end
  end

  test 'should list dojos' do
    FactoryGirl.create(:dojo)
    visit '/dojos'
    within('table tr td') do
      assert has_content? 'Faculdade XPTO'
    end
  end
end
