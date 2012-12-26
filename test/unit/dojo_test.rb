# encoding: UTF-8
require 'test_helper'

class DojoTest < ActiveSupport::TestCase
  def setup
    @dojo = Dojo.new do |dojo|
      dojo.local = 'Casa do Joãozinho'
      dojo.day = Time.now
      dojo.city = 'Atlantida'
    end
  end

  def teardown
    @dojo = nil
  end

  test 'should be invalid without a local' do
    @dojo.local = nil
    assert @dojo.invalid?, 'Local should be invalid'
  end

  test 'should require a local' do
    assert @dojo.valid?, 'Local is required'
  end

  test 'should be invalid without a day' do
    @dojo.day = nil
    assert @dojo.invalid?, 'Day should be invalid'
  end

  test 'should require a day' do
    assert @dojo.valid?, 'Day is required'
  end

  test 'should be invalid without a city' do
    @dojo.city = nil
    assert @dojo.invalid?, 'City should be invalid'
  end

  test 'should require the city' do
    assert @dojo.valid?, 'City is required'
  end

end
