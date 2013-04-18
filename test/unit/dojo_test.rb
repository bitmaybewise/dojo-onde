require 'test_helper'

class DojoTest < ActiveSupport::TestCase
  def setup
    (-10..9).each {|n| FactoryGirl.create(:dojo, day: Date.today + n) }
  end

  test "should find dojos that happened" do
    assert_equal 10, Dojo.happened.count
    assert Dojo.first.day < Date.today
    assert Dojo.last.day > Date.today
  end

  test "should find dojos that not happened" do
    assert_equal 10, Dojo.not_happened.count
    assert Dojo.first.day < Date.today
    assert Dojo.last.day >= Date.today
  end

  test "should ignore id on clone" do
    original = FactoryGirl.build(:dojo, id: 1)
    clone    = original.clone
    assert_equal nil, clone.id, "should not have id"
  end
end
