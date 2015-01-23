class ChangeImageModel < ActiveRecord::Migration
  def change
  	change_column :images, :upc, :string
  end
end
