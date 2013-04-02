# encoding: UTF-8
require 'test_helper'

class DojosTest < ActionDispatch::IntegrationTest
  def setup
    @user = FactoryGirl.create(:user)
    @dojos, @valid_dojo = [], FactoryGirl.build(:dojo)
    (-5..5).each {|n| @dojos << FactoryGirl.create(:dojo, day: Date.today + n) }
  end

  def teardown
    super
    @dojos, @valid_dojo, @user = nil, nil, nil
  end

  test 'should require login to insert' do
    visit new_dojo_path
    assert_equal login_path, current_path
    assert find('h2').has_content?('Login'), 'Should be login page'
  end

  test 'should insert' do
    with @user do
      insert @valid_dojo
      assert find('h2').has_content?(@valid_dojo.local), "Should save with success"
    end
  end

  test 'should back to homepage' do
    with @user do
      visit new_dojo_path
      click_link('Cancelar')
      assert find('h1').has_content?('Dojo, aonde?'), "Should back to homepage"
    end
  end

  test 'should edit' do
    dojo = FactoryGirl.create(:dojo)
    with @user do
      new_local = 'Lugar secreto'
      visit edit_dojo_path(dojo)
      fill_in('Local', with: new_local)
      click_button('Salvar')
      assert find('p.alert').has_content?("Dojo alterado com sucesso."),'Should edit with success'
    end
  end

  test 'should be invalid without a local' do
    @valid_dojo.local = nil
    assert_invalid @valid_dojo, "Local não pode ficar em branco"
  end

  test 'should be invalid without a day' do
    @valid_dojo.day = nil
    assert_invalid @valid_dojo, "Dia e Horário não pode ficar em branco"
  end

  test 'should be invalid with a previous day' do
    @valid_dojo.day = Date.today - 7
    assert_invalid @valid_dojo, "Dia e Horário anterior não é permitido"
  end

  test 'should require google maps link' do
    @valid_dojo.gmaps_link = nil
    assert_invalid @valid_dojo, "Link do Google Maps não pode ficar em branco"
  end

  test 'should show dojo' do
    dojo = FactoryGirl.create :dojo
    visit dojo_path(dojo)
    assert find('h2').has_content?(dojo), "Should show title with local and day"
    assert page.has_content?(dojo.user.name), "Should show user name"
    assert page.has_content?(dojo.info), "Should show info"
  end

  private
  def insert(dojo)
    visit new_dojo_path
    fill_in 'Dia', with: dojo.day
    fill_in 'Local', with: dojo.local
    fill_in 'Link do Google Maps', with: dojo.gmaps_link
    fill_in 'Outras Informações', with: dojo.info
    click_button 'Salvar'
  end

  def assert_invalid(dojo, msg)
    with @user do
      insert dojo
      assert find('div.alert').has_content?(msg), "Should show #{msg}"
    end
  end
end
