class Category < ActiveRecord::Base
	extend FriendlyId
	belongs_to :parent, :class_name => "Category"
	has_many :children,  :class_name => "Category", :foreign_key => "parent_id"
	has_many :images

	validates :name, presence: true
	friendly_id :name, use: :slugged

	before_save :slug_check

	def ancestors
		if self.parent
			return self.parent.ancestors << self
		else
			return [self]
		end
	end

	def slug_check
		self.slug += self.parent.name unless Category.where(slug: self.slug).empty? or self.parent.nil?
	end
end
