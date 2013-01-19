class User < ActiveRecord::Base
  attr_accessible :email, :name, :password

  def self.login(email, password)
    find_by_email_and_password(email, password)
  end
end
