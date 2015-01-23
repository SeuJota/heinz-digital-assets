class ChangeFieldOfImage < ActiveRecord::Migration
  def change
  	change_column :images, :upc, :decimal
  end
end
