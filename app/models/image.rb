class Image < ActiveRecord::Base
  has_attached_file :avatar, styles: { medium: "1000x", small: "500x" , show: "x400", thumb: "x200" }
  belongs_to :category
	validates :name,  presence: true
	validates :avatar, presence: true
end
