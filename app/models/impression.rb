class Impression < ActiveRecor::Base
  # the counter cache here is the important option
  belongs_to :impressionable, polymorphic: true, counter_cache: :impressions_count
end