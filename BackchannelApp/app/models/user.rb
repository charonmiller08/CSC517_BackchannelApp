class User < ActiveRecord::Base
  attr_accessible :password, :password_confirmation, :username, :role
  #attr_accessor :password
  has_many :posts
  has_many :votes

  before_save { |user| user.username = username.downcase }

  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create
  #validates :name, :presence => true
  validates :username, :presence => true
  validates :username, :uniqueness => true, :length => { :in => 3..20 }
  validates :role, :presence => true

  def self.authenticate(username, submitted_password)
    user = User.find_by_username(username)
    if(user && (user.password == submitted_password))
        return user
    else
        return false
    end
  end
end
