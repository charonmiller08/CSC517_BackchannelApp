class Post < ActiveRecord::Base
  attr_accessible :content, :title
  attr_accessible :category_id, :user_id
  belongs_to :category
  belongs_to :user
  has_many :replies

  validates :title, :presence => true
  validates :content, :presence => true

  def self.search(search_category, search)
    if search_category == "category"
      search_category = Category.where('name LIKE ?', "%#{search}%").first.id
      @posts = Post.where(:category_id => search_category).all
    elsif search && search_category
      @posts = Post.where("'#{search_category}'"+ ' LIKE ?', "%#{search}%").all
    else
      @posts = Post.all
    end
  end
end
