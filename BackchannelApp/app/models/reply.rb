class Reply < ActiveRecord::Base
  attr_accessible :title, :content, :post_id, :user_id
  belongs_to :post
  belongs_to :user

end
