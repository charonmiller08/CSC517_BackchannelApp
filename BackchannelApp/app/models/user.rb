class User < ActiveRecord::Base
  attr_accessible :name, :password, :username
  has_many :posts
  has_many :votes
  has_one :user_role

  validates :password, :presence => true
  validates :name, :presence => true
  validates :username, :presence => true
  validates :username, :uniqueness => true

end
