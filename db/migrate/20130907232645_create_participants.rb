class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.belongs_to :user
      t.belongs_to :dojo

      t.timestamps
    end
    add_index :participants, :user_id
    add_index :participants, :dojo_id
  end
end
