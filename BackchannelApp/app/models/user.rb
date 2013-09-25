class User < ActiveRecord::Base
  attr_accessible :name, :password, :role, :username
  has_many :replies
  has_many :posts
  has_many :votes

  validates :password, :presence => true
  validates :name, :presence => true
  validates :username, :presence => true
  validates :username, :uniqueness => true
  validates :role, :presence => true

end
