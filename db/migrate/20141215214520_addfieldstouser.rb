class Addfieldstouser < ActiveRecord::Migration
  def change
  	add_column :users, :cnpj, :string
    add_column :users, :profile, :string
    add_column :users, :work, :string
  end
end
