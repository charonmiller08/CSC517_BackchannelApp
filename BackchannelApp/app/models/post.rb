class Post < ActiveRecord::Base
  attr_accessible :content, :title, :tag
  attr_accessible :category_id, :user_id
  belongs_to :category
  belongs_to :user
  has_many :replies

  validates :title, :presence => true
  validates :content, :presence => true
  validates :category_id, :presence => true
  validates :tag, :presence => true

  def self.search(search_category, search)
    @posts = Post.all

    if search && search_category
      if search_category == "username"
        search_category = User.where('username LIKE ?', "%#{search}%").first
        if search_category
          @posts = Post.where(:user_id => search_category.id).all
        else
          count = User.count(:name)  + 1
          @posts = Post.where(:user_id => count)
        end
      elsif search_category == "category"
        search_category = Category.where('name LIKE ?', "%#{search}%").first
        if search_category
          @posts = Post.where(:category_id => search_category.id).all
        else
          count = Category.count(:name)  + 1
          @posts = Post.where(:category_id => count)
        end
      else
        @posts = Post.where("#{search_category}"+ ' LIKE ?', "%#{search}%").all
      end
    else
        @posts = Post.all
    end
  end

end