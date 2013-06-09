require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should login successfully" do
    new_user = FactoryGirl.create :user
    user = User.login(new_user.email, new_user.password)
    assert user, "Should get the user"
  end

  test "should save encrypted password" do
    user = FactoryGirl.create :user
    assert_not_equal user.password, user.password_digest
  end

  test "should create user from oauth hash" do
    info  = { name: "Fulano", email: "fulano@dojoonde.com" }
    hash  = { provider: "twitter", uid: "111222", info: info }
    oauth = OAuthData.new(hash)
    user  = User.create_from_auth(oauth)
    assert_equal oauth.name, user.name
    assert_equal oauth.email, user.email
    assert_equal 1, user.authentications.size
  end
end
