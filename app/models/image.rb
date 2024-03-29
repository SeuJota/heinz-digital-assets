class Image < ActiveRecord::Base
  has_attached_file :avatar, styles: { medium: "1000x", small: "500x" , show: "x400", thumb: "x200" }
  belongs_to :category
	validates :name,  presence: true
	# validates :avatar, presence: true


  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (3..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = Image.find_by_id(row["id"])
      product.update_attributes(row.to_hash)
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.search(query, cat_children)
    if query.present?
      if query.is_number?
        return where("code = :c", c: query).where("category_id IN (?)", cat_children)
      else
        where("name @@ :q", q: query).where("category_id IN (?)", cat_children)
      end
    end
  end

  def save_image_size
    unless @size_saved
      self.original_size = Paperclip.io_adapters.for(avatar(:original)).size
      self.medium_size = Paperclip.io_adapters.for(avatar(:medium)).size
      self.small_size = Paperclip.io_adapters.for(avatar(:small)).size
      @size_saved = true
      self.save
    end
  end

  def save_geometry
    unless @geometry_saved
      self.original_geometry = get_geometry(:original)
      self.medium_geometry = get_geometry(:medium)
      self.small_geometry = get_geometry(:small)
      @geometry_saved = true
      self.save
    end
  end

  def get_geometry(style = :original)
    begin
      Paperclip::Geometry.from_file(avatar.url(style)).to_s
    rescue
      nil
    end
  end
end
class String
  def is_number?
    true if Float(self) rescue false
  end
end
