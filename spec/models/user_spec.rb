require 'spec_helper'

describe User do
  it "should login successfully" do
    new_user = FactoryGirl.create(:user)
    user = User.login(new_user.email, new_user.password)
    expect(user).not_to eql(nil)
  end

  it "should save encrypted password" do
    user = FactoryGirl.create(:user)
    expect(user.password).not_to eql(user.password_digest)
  end

  it "should create user from oauth hash" do
    info  = { name: "Fulano", email: "fulano@dojoonde.com" }
    hash  = { provider: "twitter", uid: "111222", info: info }
    oauth = OAuthData.new(hash)
    user  = User.create_from_auth(oauth)

    expect(user.name).to  eql(oauth.name)
    expect(user.email).to eql(oauth.email)
    user.should have(1).authentication
  end

  it "providers_by_authentications" do
    providers       = [:twitter, :github, :facebook]
    authentications = providers.inject [] do |list, provider|
      list << Authentication.new(uid: "123", provider: provider)
    end
    user = FactoryGirl.create(:user, authentications: authentications)
    user.providers_by_authentications.should == providers
  end
end
