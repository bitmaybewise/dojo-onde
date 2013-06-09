class OAuthData
  attr_reader :uid, :provider, :name, :email

  def initialize(hash)
    @uid      = hash[:uid]
    @provider = hash[:provider]
    @name     = hash[:info][:name]
    @email    = hash[:info][:email]
  end

end
