class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :dojo

  delegate :name, to: :user
end
