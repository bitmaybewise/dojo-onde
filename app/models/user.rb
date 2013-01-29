# encoding: UTF-8

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  validates_presence_of :name,  message: "nome é obrigatório"
  validates :email, presence: { message: "e-mail é obrigatório" },
    format: { with: /[A-Za-z0-9\._-]+@[A-Za-z0-9]+\.[A-Za-z]{2,3}/, message: "e-mail inválido" },
    uniqueness: { message: "e-mail já registrado" }
  validates :password, presence: { message: "senha é obrigatória" },
    length: { minimum: 6, message: "senha deve ter no mínimo 6 caracteres" }
  validates_presence_of :password_confirmation, message: "confirme sua senha"
  validate :password_confirmation_should_be_equal_password

  def self.login(email, password)
    find_by_email(email).try(:authenticate, password)
  end

  private
  def password_confirmation_should_be_equal_password
    if password_confirmation != password
      errors.add(:password_confirmation, "valor de confirmação difere da senha")
    end
  end
end
