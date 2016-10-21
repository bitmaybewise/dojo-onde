class AddParticipantLimitToDojo < ActiveRecord::Migration
  def change
    add_column :dojos, :participant_limit, :integer, nil: false, default: 0
  end
end
