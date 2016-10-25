Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,   ENV["TWITTER_KEY"],   ENV["TWITTER_SECRET"]
  provider :github,    ENV["GITHUB_KEY"],    ENV["GITHUB_SECRET"]
  provider :facebook,  ENV["FACEBOOK_KEY"],  ENV["FACEBOOK_SECRET"]
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
end
