class Post < ActiveRecord::Base
  attr_accessible :content, :title, :tag
  attr_accessible :category_id, :user_id
  belongs_to :category
  belongs_to :user
  has_many :replies
  has_many :votes

  validates :title, :presence => true
  validates :content, :presence => true
  validates :category_id, :presence => true

  def self.search(search_category, search)
    @posts = Post.all
    #puts "ARE YOU IN HERE?"
    if search && search_category

      #if search_category == "all"
      #  @posts = Post.where('tag or content or title Like ?', "%#{search}%").all
      #  @posts = @posts + search_by_username(search)
      #  @posts = @posts + search_by_category(search)
      #  @posts = @posts.uniq

      if search_category == "username"
        search_by_username(search)
      elsif search_category == "category"
        search_by_category(search)
      else
        @posts = Post.where("#{search_category}"+ " LIKE ?", "%#{search}%").all
      end
    else
      @posts = Post.all
    end

    @posts_which_are_replies = Reply.where("post_id IN (?)", @posts)

    @post_which_are_replies_ids = []
    @posts_which_are_replies.each do |v|
      @post_which_are_replies_ids << v.post_id
    end
    puts "please work"
    puts @post_replies
    @posts = @posts - Post.where(:id => @post_which_are_replies_ids ).all
  end

  def self.search_by_category(search)
    @posts = Post.where(:category_id => Category.where('name Like ?', "%#{search}%")).all
  end
  def self.search_by_username(search)
    @posts = Post.where(:user_id => User.where('username Like ?', "%#{search}%")).all
  end


  end