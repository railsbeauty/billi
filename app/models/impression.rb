class Impression < ActiveRecord::Base
  attr_accessible :impressionable_id, :impressionable_type, :ip_address, :user_id
  belongs_to :impressionable, polymorphic: true, counter_cache: :impressions_count
end
