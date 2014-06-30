class AddAvatarToImages < ActiveRecord::Migration
  def self.up
    add_attachment :images, :avatar
    add_column :images, :name, :string, default: nil
  end

  def self.down
    remove_attachment :images, :avatar
    remove_column :images, :name, :string, default: nil
  end
end