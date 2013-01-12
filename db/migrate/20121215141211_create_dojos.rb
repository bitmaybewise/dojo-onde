class CreateDojos < ActiveRecord::Migration
  def change
    create_table :dojos do |t|
      t.string  :local
      t.date    :day
      t.integer :limit_people
      t.string  :address
      t.string  :city
      t.text    :info
      t.string  :gmaps_link

      t.timestamps
    end
  end
end
