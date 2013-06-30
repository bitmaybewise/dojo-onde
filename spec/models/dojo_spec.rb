require 'spec_helper'

describe Dojo do
  before(:each) do
    (-10..9).each {|n| FactoryGirl.create(:dojo, day: Date.today + n) }
  end

  it "should find dojos that happened" do
    Dojo.should have(10).happened
    Dojo.first.day.should < Date.today
    Dojo.last.day.should  > Date.today
  end

  it "should find dojos that not happened" do
    Dojo.should have(10).not_happened
    Dojo.first.day.should <  Date.today
    Dojo.last.day.should  >= Date.today
  end
end
