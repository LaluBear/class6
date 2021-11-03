class User < ApplicationRecord

  has_many :posts
  has_many :follows
  has_many :likes

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, length: { minimum: 2 }

  has_secure_password
	
  def get_feed_post(id)
    follows = Follow.where(follower_id: id)
    
    puts id
    puts "get feed post now"
    posts = Array(User.find(id).posts)
    
    if(follows)
      follows.each do |follow|
        posts += Array(User.find(follow.followee_id).posts)
      end
      posts = posts.sort_by{ |post| [post.created_at] }
    end
    return posts
  end
  
  def add_error_login
    errors.add(:email,"Wrong Email or Password")
  end
end
