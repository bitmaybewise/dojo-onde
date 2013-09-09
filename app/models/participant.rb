class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :dojo

  attr_accessible :user_id, :dojo_id
end
