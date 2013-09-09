require 'spec_helper'

describe Dojo do
  context "dojos that/not happen" do
    before(:each) do
      (-10..9).each {|n| FactoryGirl.create(:dojo, day: Date.today + n) }
    end

    describe "happened" do
      it "should find dojos that happened" do
        expect(Dojo).to have(10).happened
        expect(Dojo.first.day).to be < Date.today
        expect(Dojo.last.day).to  be > Date.today
      end
    end

    describe "not_happened" do
      it "should find dojos that not happened" do
        expect(Dojo).to have(10).not_happened
        expect(Dojo.first.day).to be < Date.today
        expect(Dojo.last.day).to  be >= Date.today
      end
    end
  end

  describe "save" do
    it "should add user to list of participants" do
      dojo = FactoryGirl.build(:dojo)
      dojo.save
      expect(dojo.participants).to have(1).item
      expect(dojo.participants.first.user).to eq(dojo.user)
    end

    it "shouldn't add user when present" do
      user = FactoryGirl.create(:user)
      dojo = FactoryGirl.create(:dojo, user: user)
      expect(dojo.participants).to have(1).item
      expect(dojo.participants.first.user).to eq(user)
      dojo.save
      expect(dojo.participants).to have(1).item
      expect(dojo.participants.first.user).to eq(user)
    end
  end

  describe "include_participant!" do
    it "should include participant in the list" do
      malandro = FactoryGirl.create(:user, name: "Malandro")
      dojo = FactoryGirl.create(:dojo)

      dojo.include_participant!(malandro)
      expect(malandro.participate?(dojo)).to be_true
    end
  end

  describe "remove_participant!" do
    it "should remove participant in the list" do
      malandro = FactoryGirl.create(:user, name: "Malandro")
      dojo = FactoryGirl.create(:dojo)

      dojo.include_participant!(malandro)
      expect(malandro.participate?(dojo)).to be_true

      dojo.remove_participant!(malandro)
      dojo.reload
      expect(malandro.participate?(dojo)).to be_false
    end
  end
end
