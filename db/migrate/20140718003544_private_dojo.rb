class PrivateDojo < ActiveRecord::Migration
  def change
    add_column :dojos, :private, :boolean, :default => false
  end
end
