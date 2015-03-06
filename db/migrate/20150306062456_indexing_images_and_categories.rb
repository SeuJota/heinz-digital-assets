class IndexingImagesAndCategories < ActiveRecord::Migration
  def change
  	add_index :images, :category_id, unique: true
  	add_index :categories, :parent_id, unique: true
  end
end
