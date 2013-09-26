class Post < ActiveRecord::Base
  attr_accessible :content, :title
  attr_accessible :category_id
  belongs_to :category
  belongs_to :user
  has_many :replies

  validates :title, :presence => true
  validates :content, :presence => true

end
