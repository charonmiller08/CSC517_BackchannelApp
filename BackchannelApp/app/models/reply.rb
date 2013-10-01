class Reply < ActiveRecord::Base
  attr_accessible :parent_post_id, :post_id
  belongs_to :post, :class_name => "Post"
  belongs_to :parent_post, :class_name => "Post"
  #accepts_nested_attributes_for :post
end
