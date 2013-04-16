class Article < ActiveRecord::Base
   attr_accessible :title, :body
   attr_accessible :tag_list
   has_many :comments
   belongs_to :user
   has_many :taggings
   has_many :tags, through: :taggings
   validates :title, :body, :tag_list,  :presence => true


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
