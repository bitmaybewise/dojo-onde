require 'spec_helper'

describe Dojo do
  context "dojos that/not happened" do
    before do
      (-10..9).each do |n| 
        FactoryGirl.create(:dojo, day: Date.today + n)
      end
    end

    describe ".happened" do
      it "find dojos that happened" do
        expect(Dojo.happened.size).to eq 10
      end
    end

    describe ".not_happened" do
      it "find dojos that not happened" do
        expect(Dojo.not_happened.size).to eq 10
      end
    end
  end

  describe ".publishable" do
    it "find dojos that are publishable" do
      FactoryGirl.create(:dojo, private: true)
      FactoryGirl.create(:dojo, private: false)
      expect(Dojo.publishable.size).to eq 1
    end
  end

  describe "#save" do
    it "should add user to list of participants" do
      dojo = FactoryGirl.build(:dojo)
      dojo.save
      expect(dojo.participants.size).to eq 1
      expect(dojo.participants.first.user).to eq(dojo.user)
    end

    it "shouldn't add user when present" do
      user = FactoryGirl.create(:user)
      dojo = FactoryGirl.create(:dojo, user: user)
      expect(dojo.participants.size).to eq 1
      expect(dojo.participants.first.user).to eq(user)
      dojo.save
      expect(dojo.participants.size).to eq 1
      expect(dojo.participants.first.user).to eq(user)
    end
  end

  describe "#include_participant!" do
    it "should include participant in the list" do
      malandro = FactoryGirl.create(:user, name: "Malandro")
      dojo = FactoryGirl.create(:dojo)

      dojo.include_participant!(malandro)
      expect(malandro.participate?(dojo)).to be_truthy
    end
  end

  describe "#remove_participant!" do
    it "should remove participant in the list" do
      malandro = FactoryGirl.create(:user, name: "Malandro")
      dojo = FactoryGirl.create(:dojo)

      dojo.include_participant!(malandro)
      expect(malandro.participate?(dojo)).to be_truthy

      dojo.remove_participant!(malandro)
      dojo.reload
      expect(malandro.participate?(dojo)).to be_falsey
    end
  end

  describe '#to_s' do
    let(:dojo) { Dojo.new(day: Date.today, local: 'bla') }
    let(:day_formatted) { Date.today.strftime("%d-%m-%Y %H:%M\h") }

    context 'when publishable' do
      it { expect(dojo.to_s).to eq "#{day_formatted} - bla" }
    end

    context 'when private' do
      before do
        dojo.private = true
      end
      it { expect(dojo.to_s).to eq "[PRIVADO] #{day_formatted} - bla" }
    end
  end
end
