class UserRole < ActiveRecord::Base
  attr_accessible :role
  belongs_to :user

  validates :role, :presence => true
  validates :role, :uniqueness => true

end
