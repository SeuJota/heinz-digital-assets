class Category < ActiveRecord::Base
	extend FriendlyId
	belongs_to :parent, :class_name => "Category"
	has_many :children,  :class_name => "Category", :foreign_key => "parent_id"
	has_many :images

	validates :name, presence: true
  friendly_id :slug_candidates, use: :slugged
	scope :leafs, -> {Category.all.select {|c| c.is_leaf?}}
	scope :included?, ->(cat) {where("")}

	def is_leaf?
		false
		true if self.children.empty?
	end

	def slug_candidates
		[
			:name,
			[:name, parent.id]
		]
	end

	def ancestors
		if self.parent
			return self.parent.ancestors << self
		else
			return [self]
		end
	end

	def children_id
		unless self.children.blank?
			list = []
			self.children.each do |c|
				list << c.children_id
			end
			return list.flatten! << self.id
		else
			return [self.id]
		end
	end
end
