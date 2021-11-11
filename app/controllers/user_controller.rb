class UserController < ApplicationController
  before_action :logged_in, only: %i[ feed new_post create_post user_profile ]
  def login
    session[:user_id] = nil
    @user = User.new
    if(flash[:error]=="Wrong Email or Password!")
      @user.errors.add(:base,"Wrong Email or Password")
    end
  end
  
  def login_attempt
    
    @user = User.find_by(email: params[:user][:email])
    
    puts params[:user][:email]
    puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    if(@user && @user.authenticate(params[:user][:password]))
      session[:user_id] = @user.id
      redirect_to "/feed"
    else
      redirect_to "/main", flash: { error: "Wrong Email or Password!" }
    end
  end
  
  def logout
    
    session[:user_id] = nil
    redirect_to "/main"
  end
  
  def new_user
    @user = User.new
  end
  
  def create_user
    @user = User.new(email: params[:user][:email], name: params[:user][:name], password: params[:user][:password])
    @user.save
    redirect_to "/main"
    return
  end
  
  def feed
    @user_id = session[:user_id]
    @user = User.find(@user_id)
    @posts = @user.get_feed_post(@user_id)
    @showmodal = params[:showmodal]
    
    puts @posts
    puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  end
  
  def new_post
    @post = Post.new(user_id: session[:user_id])
  end
  
  def create_post
    @post = Post.new(post_params)
    @post.save
    redirect_to "/feed"
    return
  end
  
  def user_profile
    @user = User.find_by(name: params[:name])
    @is_self = (@user.id == session[:user_id])
    @is_follow = Follow.find_by(follower_id: session[:user_id], followee_id: @user.id)
    puts @user
    puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  end
  
  def follow
    @follow = Follow.new(follower_id: session[:user_id], followee_id: params[:id])
    @follow.save
    redirect_back(fallback_location:"/")
  end
  
  def unfollow  
    
    @follow = Follow.find_by(follower_id: session[:user_id], followee_id: params[:id])
    @follow.destroy
    redirect_back(fallback_location:"/")
  end
  
  def like
    @like = Like.new(user_id: session[:user_id], post_id: params[:id])
    @like.save
    redirect_back(fallback_location:"/")
  end
  
  def unlike  
    
    @like = Like.find_by(user_id: session[:user_id], post_id: params[:id])
    @like.destroy
    redirect_back(fallback_location:"/")
  end
  
  
  def get_dataset
    render json: { data: User.all }
  end
  
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def logged_in
      if(session[:user_id])
        a = 1
      else
        session[:user_id] = nil
        redirect_to "/main", notice: "Please login"
        return
      end
    end
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :password)
    end
    
    def post_params
      params.require(:post).permit(:msg, :user_id)
    end
end
