class CreateDojos < ActiveRecord::Migration
  def change
    create_table :dojos do |t|
      t.datetime  :day
      t.string    :local
      t.text      :info
      t.text      :gmaps_link

      t.timestamps
    end
  end
end
