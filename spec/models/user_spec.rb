require 'spec_helper'

describe User do
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

  describe "#create_from_auth" do
    it "should create user from oauth hash" do
      info  = { name: "Fulano", email: "fulano@dojoonde.com" }
      hash  = { provider: "twitter", uid: "111222", info: info }
      oauth = OAuthData.new(hash)
      user  = User.create_from_auth(oauth)
      expect(user.name).to  eql(oauth.name)
      expect(user.email).to eql(oauth.email)
      expect(user).to have(1).authentication
    end
  end
  
  describe "#providers_by_authentications" do
    it "should get providers by authentications" do
      providers       = [:twitter, :github, :facebook]
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
      expect(user.participate?(dojo)).to be_true
    end

    it "should false when user not participate of the dojo" do
      dojo = FactoryGirl.create(:dojo)
      expect(user.participate?(dojo)).to be_false
    end
  end
end
