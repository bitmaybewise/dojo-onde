class CreateRetrospectives < ActiveRecord::Migration
  def change
    create_table :retrospectives do |t|
      t.string :challenge
      t.text   :positive_points
      t.text   :improvement_points
      t.belongs_to :dojo

      t.timestamps
    end
    add_index :retrospectives, :dojo_id
  end
end
