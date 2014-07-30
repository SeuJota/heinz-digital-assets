class AddDimentionsToImage < ActiveRecord::Migration
  def change
    add_column :images, :original_geometry, :string
    add_column :images, :medium_geometry, :string
    add_column :images, :small_geometry, :string
  end
end
