class AddColumnsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :master, :boolean, default: false
    add_column :users, :approver, :boolean, default: false
  end
end
