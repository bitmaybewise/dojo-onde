require 'test_helper'

class DojosTest < ActionDispatch::IntegrationTest
  def setup
    FactoryGirl.create(:dojo)
  end

  test 'should insert dojo' do
    local_name = 'Faculdade XYZ'
    visit root_url
    click_link('Novo dojo')
    fill_in('Local', with: local_name)
    click_button('Salvar')
    within('h2') do
      assert has_content? local_name
    end
  end

  test 'should go to list page from edit page' do
    visit '/dojos/1'
    click_link('Voltar')
    within('h2') do
      assert has_content? 'Dojos cadastrados'
    end
  end

  test 'should edit dojo' do
    visit '/dojos'
    click_link('Editar')
    fill_in('Local', with: 'Local alterado')
    click_button('Salvar')
    within('h2') do
      assert has_content? 'Dojo Local alterado'
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
    visit '/dojos'
    within('table tr td:first') do
      assert has_content? 'Faculdade XPTO'
    end
  end

  test 'should delete dojo' do
    visit '/dojos'
    click_link('Excluir')
    within('table tr') do
      assert has_no_content? 'Faculdade XPTO'
    end
  end
end
