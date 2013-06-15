# encoding: UTF-8
require 'test_helper'

class SocialAuthTest < ActionDispatch::IntegrationTest
  twitter  = { provider: "twitter", uid: "111111", info: 
      { name: "Fulano de Tal", email: "fulano@dojoonde.com.br" } }
  github   = { provider: "github", uid: "222222", info: 
      { name: "Cicrano de Tal", email: "cicrano@dojoonde.com.br" } }
  facebook = { provider: "facebook", uid: "333333", info: 
      { name: "Beltrano de Tal", email: "beltrano@dojoonde.com.br" } }
  accounts = [twitter, github, facebook]

  accounts.each do |account|
    omniauth = OmniAuth.config.add_mock(account[:provider], account)
    oauth    = OAuthData.new(omniauth)

    test "should login with #{oauth.provider} account" do
      visit     "/login"
      click_on  oauth.provider
      assert    page.has_content?(oauth.name)
    end
  end

  test "should link to account that email already exists" do
    omniauth = OmniAuth.config.add_mock(:github, github)
    oauth    = OAuthData.new(omniauth)
    user     = FactoryGirl.create(:user, email: oauth.email)

    visit        login_path
    click_on     "github"
    assert_equal 1, User.count, "should exists only 1 user"
    assert_equal 1, user.authentications.count, "should exists only 1 auth for user"
  end

  test "should link to account once" do
    omniauth = OmniAuth.config.add_mock(:github, github)
    oauth    = OAuthData.new(omniauth)
    user     = FactoryGirl.create(:user, email: oauth.email)

    2.times do
      visit     login_path
      click_on  "github"
      logout
    end
    assert_equal 1, user.authentications.count, "should exists only 1 auth for the user"
  end

  test "should fail with invalid credentials" do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    visit     login_path 
    click_on  "github"
    assert    page.has_content?("Erro durante autenticação!"), "should show failure message"
  end

  accounts.each do |account|
    omniauth = OmniAuth.config.add_mock(account["provider"], account)
    oauth    = OAuthData.new(omniauth)

    test "should link with #{oauth.provider} from user page" do
      user = FactoryGirl.create(:user)
      with user do
        visit edit_user_path(user)
        element = "##{oauth.provider}"
        find(element).click_on("vincular")

        assert_equal edit_user_path(user), current_path,
          "should back to user page"
        assert find(element).has_content?("conectado"),
          "should appear connected account"
      end
    end
  end

end
