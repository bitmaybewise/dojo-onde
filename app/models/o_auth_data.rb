class OAuthData
  attr_reader :uid, :provider, :name, :email

  def initialize(hash)
    @uid      = hash[:uid]
    @provider = hash[:provider]
    @name     = hash.fetch(:info, {})[:name]
    @email    = hash.fetch(:info, {})[:email]
  end
end
