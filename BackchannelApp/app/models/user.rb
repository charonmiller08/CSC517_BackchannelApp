class User < ActiveRecord::Base
  attr_accessible :name, :password, :username
  has_many :posts
  has_many :votes
  has_one :user_role

  before_save { |user| user.username = username.downcase }

  validates :password, :presence => true
  validates :name, :presence => true
  validates :username, :presence => true
  validates :username, :uniqueness => true

  def self.authenticate(username, submitted_password)
    user = User.find_by_username(username);
    if(user && (user.password == submitted_password))
        return true
    end
    return nil if user.nil?

  end
end
