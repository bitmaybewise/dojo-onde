require 'spec_helper'

describe User, type: :model do
  describe "#save" do
    it "should save encrypted password" do
      user = FactoryGirl.create(:user)
      expect(user.password).not_to eql(user.password_digest)
    end
  end

  describe ".login" do
    it "should login successfully" do
      new_user = FactoryGirl.create(:user)
      user = User.login(new_user.email, new_user.password)
      expect(user).not_to be_nil
    end
  end

  describe "#providers_by_authentications" do
    it "should get providers by authentications" do
      providers       = [:twitter, :github, :facebook].map(&:to_s)
      authentications = providers.inject [] do |list, provider|
        list << Authentication.new(uid: "123", provider: provider)
      end
      user = FactoryGirl.create(:user, authentications: authentications)
      expect(user.providers_by_authentications).to eql(providers)
    end

    it "should be empty when has no providers" do
      user = FactoryGirl.create(:user, authentications: [])
      expect(user.providers_by_authentications).to be_empty
    end
  end

  describe "participate?" do
    let(:user) { FactoryGirl.create(:user) }

    it "should true when user participate of the dojo" do
      dojo = FactoryGirl.create(:dojo, user: user)
      expect(user.participate?(dojo)).to be_truthy
    end

    it "should false when user not participate of the dojo" do
      dojo = FactoryGirl.create(:dojo)
      expect(user.participate?(dojo)).to be_falsey
    end
  end

  describe "can_manage?" do
    it "cannot manage when is not the owner" do
      user = FactoryGirl.create(:user)
      dojo = FactoryGirl.create(:dojo)

      expect(user.can_manage?(dojo.id)).to be_falsey
    end

    it "can manage when is the owner" do
      user = FactoryGirl.create(:user)
      dojo = FactoryGirl.create(:dojo, user: user)

      expect(user.can_manage?(dojo.id)).to be_truthy
    end
  end
end
