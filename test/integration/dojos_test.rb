require 'test_helper'

class DojosTest < ActionDispatch::IntegrationTest
  def setup
    FactoryGirl.create(:dojo, local: 'Faculdade')
  end

  test 'should insert dojo' do
    visit root_url
    click_link('Novo dojo')
    fill_in('Local', with: 'Novo local')
    click_button('Salvar')
    within('h2') do
      assert has_content? 'Novo local'
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
    10.times { FactoryGirl.create(:dojo) }
    visit '/dojos'
    within('tbody tr:first') do
      assert has_content? 'Faculdade'
    end
    within('tbody tr:last') do
      assert has_content? 'Faculdade10'
    end
  end

  test 'should delete dojo' do
    visit '/dojos'
    click_link('Excluir')
    within('table tr') do
      assert has_no_content? 'Faculdade'
    end
  end
end
