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
    find_by(email: email).try(:authenticate, password)
  end

  def providers_by_authentications
    authentications.map(&:provider)
  end

  def participate?(dojo)
    dojo.participants.find_by(user_id: id).present?
  end

  def can_manage?(dojo_id)
    dojo_ids.include?(dojo_id)
  end
end
