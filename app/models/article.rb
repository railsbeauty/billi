class Article < ActiveRecord::Base
   attr_accessible :title, :body
   attr_accessible :tag_list
   has_many :comments
   belongs_to :user
   has_many :taggings, :dependent => :destroy
   has_many :tags, through: :taggings , :dependent => :destroy
    has_many :impressions, as: :impressionable 
   validates :title, :body, :tag_list,  :presence => true

  def impression_count
    impressions.size
  end

  def unique_impression_count
    impressions.group(:ip_address).size #UNTESTED: might not be correct syntax
  end

   def tag_list
     self.tags.collect do |tag|
      tag.name
     end.join(", ")
   end

   def tag_list=(tags_string)
     tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
     new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by_name(name) }
     self.tags = new_or_found_tags
   end
end
