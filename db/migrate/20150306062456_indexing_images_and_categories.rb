class IndexingImagesAndCategories < ActiveRecord::Migration
  def change
  	add_index :images, :category_id
  	add_index :categories, :parent_id
  end
end
