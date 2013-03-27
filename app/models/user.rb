# encoding: UTF-8

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation, :dojos
  has_many :dojos

  validates_presence_of :name,  message: "nome é obrigatório"
  validates :email, presence: { message: "e-mail é obrigatório" },
    format: { with: /[A-Za-z0-9\._-]+@[A-Za-z0-9]+\.[A-Za-z]{2,3}/, message: "e-mail inválido" },
    uniqueness: { message: "e-mail já registrado" }

  with_options unless: :skip_password? do |user|
    user.validates :password, presence: { message: "senha é obrigatória" },
      length: { minimum: 6, message: "senha deve ter no mínimo 6 caracteres" },
      confirmation: { message: "confirmação não bate" }
    user.validates :password_confirmation, presence: { message: "confirmação é obrigatória" }
  end

  def self.login(email, password)
    find_by_email(email).try(:authenticate, password)
  end

  private
  def skip_password?
     self.id.present? && (self.name.present? && self.email.present?) && self.password.nil?
  end
end
