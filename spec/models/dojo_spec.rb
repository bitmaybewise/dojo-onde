require 'spec_helper'

describe Dojo do
  before(:each) do
#    (-10..9).each {|n| FactoryGirl.create(:dojo, day: Date.today + n) }
  end

  it "should find dojos that happened" do
    expect(Dojo.happened.count).to eql(10)
    expect(Dojo.first.day < Date.today).to be_true
    expect(Dojo.last.day > Date.today).to be_true
  end

  it "should find dojos that not happened" do
    expect(Dojo.not_happened.count).to eql(10)
    expect(Dojo.first.day < Date.today).to be_true
    expect(assert Dojo.last.day >= Date.today).to be_true
  end
end
