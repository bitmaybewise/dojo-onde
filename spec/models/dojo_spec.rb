require 'spec_helper'

describe Dojo do
  before(:each) do
    (-10..9).each {|n| FactoryGirl.create(:dojo, day: Date.today + n) }
  end

  it "should find dojos that happened" do
    expect(Dojo).to have(10).happened
    expect(Dojo.first.day).to be < Date.today
    expect(Dojo.last.day).to  be > Date.today
  end

  it "should find dojos that not happened" do
    expect(Dojo).to have(10).not_happened
    expect(Dojo.first.day).to be < Date.today
    expect(Dojo.last.day).to  be >= Date.today
  end
end
