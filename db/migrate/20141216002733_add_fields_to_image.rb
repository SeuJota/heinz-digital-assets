class AddFieldsToImage < ActiveRecord::Migration
  def change
    add_column :images, :upc, :integer
    add_column :images, :dim_unit, :string
    add_column :images, :weight_unit, :string
    add_column :images, :box_unit, :string
    add_column :images, :dim_box, :string
    add_column :images, :weight_box, :string
    add_column :images, :box_pallet, :string
    add_column :images, :description, :string
  end
end
