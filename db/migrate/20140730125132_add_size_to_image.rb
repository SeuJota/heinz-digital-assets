class AddSizeToImage < ActiveRecord::Migration
  def change
    add_column :images, :original_size, :integer
    add_column :images, :medium_size, :integer
    add_column :images, :small_size, :integer
  end
end
