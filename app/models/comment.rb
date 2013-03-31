class Comment < ActiveRecord::Base
  attr_accessible :article_id, :content, :user_id
  belongs_to :user
  belongs_to :article
end
