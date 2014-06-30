class AddHeightToCategory < ActiveRecord::Migration
  def change
  	add_column :categories, :height, :integer, default: 0
  end
end
