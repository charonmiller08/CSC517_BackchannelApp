class Reply < ActiveRecord::Base
  attr_accessible :title, :content
  belongs_to :post
  belongs_to :user

end
