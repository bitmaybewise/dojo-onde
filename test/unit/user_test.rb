require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Should login successfully" do
    new_user = FactoryGirl.create :user
    user = User.login(new_user.email, new_user.password)
    assert user, "Should get the user"
  end

  test "Should save encrypted password" do
    user = FactoryGirl.create :user
    assert_not_equal user.password, user.password_digest
  end
end
