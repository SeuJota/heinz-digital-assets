class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :area, :string
    add_column :users, :company, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
  end
end
