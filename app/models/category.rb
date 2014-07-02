class Category < ActiveRecord::Base
	extend FriendlyId
	belongs_to :parent, :class_name => "Category"
	has_many :children,  :class_name => "Category", :foreign_key => "parent_id"
	has_many :images

	validates :name, presence: true
	friendly_id :slug_candidates, use: :slugged

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :name,
      [:name, self.parent.name],
    ]
  end
	def ancestors
		if self.parent
			return self.parent.ancestors << self
		else
			return [self]
		end
	end
end
