require 'test_helper'

class DojosTest < ActionDispatch::IntegrationTest
  def setup
    @dojos = []; c = -5
    10.times do
      @dojos << FactoryGirl.create(:dojo, day: Date.today + c)
      c += 1
    end
    @first = @dojos.first
  end

  def teardown
    @first = nil; @dojos = nil
  end

  test 'should insert dojo' do
    local = "Um lugar qualquer"

    visit root_url
    click_link('Novo dojo')
    fill_in('Local', with: local)
    fill_in('Dia', with: Date.today)
    fill_in('Cidade', with: 'Atlantida')
    click_button('Salvar')
    within('h2') do
      assert has_content? local
    end
  end

  test 'should go to list page from edit page' do
    visit "/dojos/#{@first.id}"
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

  test 'should show list of dojos' do
    visit '/dojos'
    within('tbody tr:first') do
      assert has_content? @first.local
    end
    within('tbody tr:last') do
      assert has_content? @dojos.last.local
    end
  end

  test 'should show list of dojos that happened with the most recent first' do
    @dojos.delete_if { |dojo| dojo.day >= Date.today }

    visit '/dojos/aconteceram'
    within('table tbody tr:first') do
      assert has_content?(@dojos.last.local), "First should have most recent date"
    end
  end

  test 'should edit dojo' do
    local = 'lugar secreto'

    visit '/dojos'
    within("table tbody tr:first") { click_link('Editar') }
    fill_in('Local', with: local)
    click_button('Salvar')
    within('h2') do
      assert has_content? "Dojo #{local}"
    end
  end

  test 'should delete dojo' do
    visit '/dojos'
    within('table tbody tr:first') { click_link('Excluir') }
    within('table tbody tr:first') do
      assert has_no_content? @first.local
    end
  end
end
