require 'test_helper'

class OAuthDataTest < ActiveSupport::TestCase
  test "should initialize from hash" do
    hash = {
      uid: "123456", provider: "twitter", info: {
        name: "fulano", email: "fulano@dojoonde.com.br"
      }
    }
    oauth = OAuthData.new(hash)
    assert_equal hash[:uid], oauth.uid, "uid should be equal"
    assert_equal hash[:provider], oauth.provider, "provider should be equal"
    assert_equal hash[:info][:name], oauth.name, "name should be equal"
    assert_equal hash[:info][:email], oauth.email, "name should be equal"
  end
end
