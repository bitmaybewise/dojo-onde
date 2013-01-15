# encoding: UTF-8
require 'test_helper'

class DojosTest < ActionDispatch::IntegrationTest
  def setup
    @dojos = []
    (-5..5).each {|n| @dojos << FactoryGirl.create(:dojo, day: Date.today + n) }
    @first      = @dojos.first
    @valid_dojo = FactoryGirl.build(:dojo)
  end

  def teardown
    @first = nil
    @dojos = nil
    @valid_dojo = nil
  end

  test 'should insert dojo' do
    insert @valid_dojo
    within('h2') do
      assert has_content?("Dojo #{@valid_dojo.local}"), "Should show '#{@valid_dojo.local}' on title"
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

  test 'should show list of dojos that not happened with the recent first' do
    @dojos.delete_if {|dojo| dojo.day < Date.today }

    visit dojos_url
    within('tbody tr:first') do
      assert has_content?(@dojos.last.local), "First should have recent date"
    end
    within('tbody tr:last') do
      assert has_content?(@dojos.first.local), "Last should have older date"
    end
  end

  test 'should show list of dojos that happened with the recent first' do
    @dojos.delete_if { |dojo| dojo.day >= Date.today }

    visit '/dojos/aconteceram'
    within('table tbody tr:first') do
      assert has_content?(@dojos.last.local), "First should have recent date"
    end
    within('table tbody tr:last') do
      assert has_content?(@dojos.first.local), "First should have older date"
    end
  end

  test 'should edit dojo' do
    local = 'lugar secreto'

    visit dojos_url
    within("table tbody tr:first") { click_link('Editar') }
    fill_in('Local', with: local)
    click_button('Salvar')
    within('h2') do
      assert has_content? "Dojo #{local}"
    end
  end

  test 'should delete dojo' do
    visit dojos_url
    within('table tbody tr:first') { click_link('Excluir') }
    within('table tbody tr:first') do
      assert has_no_content? @first.local
    end
  end

  test 'should be invalid without a local' do
    @valid_dojo.local = nil
    assert_invalid @valid_dojo, "local é obrigatório"
  end

  test 'should be invalid without a address' do
    @valid_dojo.address = nil
    assert_invalid @valid_dojo, "endereço é obrigatório"
  end

  test 'should be invalid without a city' do
    @valid_dojo.city = nil
    assert_invalid @valid_dojo, "cidade é obrigatória"
  end

  test 'should be invalid without a day' do
    @valid_dojo.day = nil
    assert_invalid @valid_dojo, "dia é obrigatório"
  end

  test 'should be invalid with a previous day' do
    @valid_dojo.day = Date.today - 7
    assert_invalid @valid_dojo, "dias anteriores não são permitidos"
  end

  test 'should show dojo' do
    dojo = FactoryGirl.create :dojo
    visit dojo_path(dojo)
    assert page.has_content?("Local: #{dojo.local}"), "Should show local"
    assert page.has_content?("Dia: #{dojo.day}"), "Should show day"
    assert page.has_content?("Limite de participantes: #{dojo.limit_people}"), "Should show limit people"
    assert page.has_content?("Endereço: #{dojo.address}"), "Should show address"
    assert page.has_content?("Cidade: #{dojo.city}"), "Should show city"
    assert page.has_content?("Informações: #{dojo.info}"), "Should show info"
  end

  private
  def insert(dojo)
    visit root_url
    click_link 'Novo dojo'
    fill_in 'Local',    with: dojo.local
    fill_in 'Dia',      with: dojo.day
    fill_in 'Endereço', with: dojo.address
    fill_in 'Cidade',   with: dojo.city
    fill_in 'Limite de participantes', with: dojo.limit_people
    fill_in 'Outras informações', with: dojo.info
    click_button 'Salvar'
  end

  def assert_invalid(dojo, msg)
    insert dojo
    within('div#error_explanation') do
      assert has_content?(msg), "Should show #{msg}"
    end
  end
end
