require 'spec_helper'

describe Dojo do
  let(:dojo_with_limit) { Dojo.new(day: Time.zone.now, local: 'bla', participant_limit: 3) }
  let(:dojo) { FactoryGirl.build(:dojo) }
  let(:new_user){ FactoryGirl.create(:user, name: "Malandro") }

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
    context 'when Dojo has not participant limit' do
      it "should include participant in the list" do
        malandro = FactoryGirl.create(:user, name: "Malandro")
        dojo = FactoryGirl.create(:dojo)

        dojo.include_participant!(malandro)
        expect(malandro.participate?(dojo)).to be_truthy
      end
    end

    context 'when Dojo has participant limit' do
      it "don't allow new subscriptions" do
        participants = double("Participant")
        allow(participants).to receive(:size).and_return(4)
        allow(dojo_with_limit).to receive(:participants).and_return(participants)

        expect { dojo_with_limit.include_participant!(new_user) }.to raise_error(Dojoonde::ParticipantLimitError)
      end
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
      expect(dojo.has_participant?(malandro)).to be_falsey
    end
  end

  describe '#has_limit?' do
    context 'when Dojo has not participant limit' do
      it "should be false" do
        dojo = FactoryGirl.create(:dojo)
        expect(dojo.has_limit?).to be(false)
      end
    end
  end

  context 'when Dojo nas limit' do
    it {  expect(dojo_with_limit.has_limit?).to be(true) }
  end

  describe '#reached_limit?' do
    context 'when Dojo has not limit' do
      it 'should be false' do
        dojo = FactoryGirl.create(:dojo)
        expect(dojo.reached_limit?).to be(false)
      end
    end

    context 'when Dojo has limit' do
      it 'should be true' do
        participants = double("Participant")
        allow(participants).to receive(:size).and_return(4)
        allow(dojo_with_limit).to receive(:participants).and_return(participants)

        expect(dojo_with_limit.reached_limit?).to be(true)
      end
    end
  end

  describe "#has_participant?" do
    context 'when participant are registered' do
      it 'be true' do
        malandro = FactoryGirl.create(:user, name: "Malandro")
        dojo = FactoryGirl.create(:dojo)

        dojo.has_participant?(malandro)
      end
    end

    context 'when participant are not registered' do
      it 'be false' do
        user = FactoryGirl.create(:user)
        expect(dojo.has_participant?(user)).to be(false)
      end
    end
  end

  describe '#to_s' do
    let(:dojo) { Dojo.new(day: Time.zone.now, local: 'bla') }
    let(:day_formatted) { Time.zone.now.strftime("%d/%m/%Y %H:%M\h") }

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

  describe "#belongs_to?" do
    context "when user is dojo's owner" do
      it do
        expect(dojo.belongs_to?(dojo.user)).to be true
      end
    end

    context "when user isn't dojo's owner" do
      it do
        other_user = FactoryGirl.create(:user, name: "Other guy", email: 'other_email-123@gmail.com')
        expect(dojo.belongs_to?(other_user)).to be false
      end
    end
  end
end
