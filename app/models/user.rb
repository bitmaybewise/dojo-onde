class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  def self.login(email, password)
    User.find_by_email(email).authenticate(password)
  end
end
