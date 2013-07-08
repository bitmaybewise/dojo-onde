require 'spec_helper'

describe OAuthData do
  it "should initialize from hash" do
    info = { name: "fulano", email: "fulano@dojoonde.com.br" }
    hash = { uid: "123456", provider: "twitter", info: info }
    oauth = OAuthData.new(hash)

    expect(oauth.uid).to      eql hash[:uid]
    expect(oauth.provider).to eql hash[:provider]
    expect(oauth.name).to     eql hash[:info][:name]
    expect(oauth.email).to    eql hash[:info][:email]
  end
end
