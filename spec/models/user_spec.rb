require 'spec_helper'

describe User do
  it "Should login successfully" do
    new_user = FactoryGirl.create :user
    user = User.login(new_user.email, new_user.password)
    expect(user).to eql("Should get the user")
  end

  it "Should save encrypted password" do
    user = FactoryGirl.create :user
    expect(user.password).not_to eql(user.password_digest)
  end
end
