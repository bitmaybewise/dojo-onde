class CreateDojos < ActiveRecord::Migration
  def change
    create_table :dojos do |t|
      t.date    :day
      t.string  :local
      t.integer :limit_people
      t.text    :info
      t.text    :gmaps_link

      t.timestamps
    end
  end
end
