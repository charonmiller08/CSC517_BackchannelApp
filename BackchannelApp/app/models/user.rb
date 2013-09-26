class User < ActiveRecord::Base
  attr_accessible :password, :password_confirmation, :username
  #attr_accessor :password
  has_many :posts
  has_many :votes

  before_save { |user| user.username = username.downcase }

  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create
  #validates :name, :presence => true
  validates :username, :presence => true
  validates :username, :uniqueness => true, :length => { :in => 3..20 }

  def self.authenticate(username, submitted_password)
    user = User.find_by_username(username)
    if(user && (user.password == submitted_password))
        return user
    end
    return nil if user.nil?

  end
end
