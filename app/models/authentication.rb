class Authentication < ActiveRecord::Base
  belongs_to :user

  def self.from_oauth!(oauth, current_user = nil)
    ActiveRecord::Base.transaction do
      user  = current_user || User.find_or_initialize_by(email: oauth.email)
      user.assign_attributes(name: oauth.name)
      user.save(validate: false)
      user.authentications.find_or_create_by(uid: oauth.uid, provider: oauth.provider)
      user
    end
  end
end
