class AddColumnsToImage < ActiveRecord::Migration
  def change
    add_column :images, :code, :integer
  end
end
