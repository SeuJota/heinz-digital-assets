module CategoriesHelper
	  def nested_category_path(category)
    '/' + (category.ancestors).map(&:to_param).join('/')
  end
end
