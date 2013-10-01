class Post < ActiveRecord::Base
  attr_accessible :content, :title, :tag
  attr_accessible :category_id, :user_id
  belongs_to :category
  belongs_to :user
  has_many :replies

  validates :title, :presence => true
  validates :content, :presence => true
  validates :category_id, :presence => true

  def self.search(search_category, search)
    @posts = Post.all

    if search && search_category
      if search_category == "all"
        @posts = Post.where('tag or content or title Like ?', "%#{search}%").all
        #@posts = @posts + Post.where(:user_id => User.where('username Like ?', "%#{search}%")).all
        @posts = @posts + search_by_username(search)
        #@posts = @posts + Post.where(:category_id => Category.where('name Like ?', "%#{search}%")).all
        @posts = @posts + search_by_category(search)
        @posts = @posts.uniq
      elsif search_category == "username"
        search_by_username(search)
      elsif search_category == "category"
        search_by_category(search)
      else
        @posts = Post.where("#{search_category}"+ " LIKE ?", "%#{search}%").all
      end                             else
      @posts = Post.all
    end
  end

  def self.search_by_category(search)
    #search_category = Category.where("name LIKE ?", "%#{search}%").first
    @posts = Post.where(:category_id => Category.where('name Like ?', "%#{search}%")).all
    #if search_category
    #  @posts = Post.where(:category_id => search_category.id).all
    #else
    #  count = Category.count(:name)  + 1
    #  @posts = Post.where(:category_id => count)
    #end
  end
  def self.search_by_username(search)
    @posts = Post.where(:user_id => User.where('username Like ?', "%#{search}%")).all
  end


  end