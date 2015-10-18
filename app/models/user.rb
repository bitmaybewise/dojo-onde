class User < ActiveRecord::Base
  has_secure_password(validations: false)

  has_many :dojos, dependent: :destroy
  has_many :authentications, dependent: :destroy

  validates_presence_of :name
  validates :email, presence: true, uniqueness: true,
    format: { with: /\A[^@]+@[^@]+\z/ }

  validates :password, length: { minimum: 6 }, :on => :create
  validates_confirmation_of :password, if: ->(u) { u.password.present? }
  validates_presence_of     :password_confirmation, if: ->(u) { u.password.present? }

  def self.login(email, password)
    find_by_email(email).try(:authenticate, password)
  end

  def providers_by_authentications
    authentications.map { |auth| auth.provider }
  end

  def participate?(dojo)
    present = false
    dojo.participants.each { |participant| present = true if participant.user == self }
    present
  end
end
