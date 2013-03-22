class CreateDojos < ActiveRecord::Migration
  def change
    create_table :dojos do |t|
      t.datetime  :day
      t.string    :local
      t.text      :info
      t.text      :gmaps_link
      t.belongs_to :user

      t.timestamps
    end
  end
end
