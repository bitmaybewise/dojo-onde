# encoding: UTF-8

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation, :dojos
  has_many :dojos

  validates_presence_of :name
  validates :email, presence: true, uniqueness: true,
    format: { with: /[A-Za-z0-9\._-]+@[A-Za-z0-9]+\.[A-Za-z]{2,3}/ }

  with_options unless: :skip_password? do |user|
    user.validates :password, length: { minimum: 6 }
    user.validates_presence_of :password_confirmation
  end

  def self.login(email, password)
    find_by_email(email).try(:authenticate, password)
  end

  private
  def skip_password?
     self.id.present? && (self.name.present? && self.email.present?) && self.password.nil?
  end
end
