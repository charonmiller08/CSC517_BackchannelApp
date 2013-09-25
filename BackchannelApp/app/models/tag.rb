class Tag < ActiveRecord::Base
  attr_accessible :tag
  belongs_to :post

  validates :tag, :presence => true

end
