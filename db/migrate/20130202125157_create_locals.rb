class CreateLocals < ActiveRecord::Migration
  def change
    create_table :locals do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.belongs_to :dojo

      t.timestamps
    end
    add_index :locals, :dojo_id
  end
end
