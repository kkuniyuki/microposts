class UsersController < ApplicationController
before_action :authenticate_user!, only: [:edit, :update]

  def show
    p params[:id]
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  # def index
  #   @user = User.find(params[:id])
  # end

  def edit
    @user = User.find(params[:id])
  end
  
  def update

    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "編集できました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def following
    p @user = User.find(params[:id])
    followingall = Relationship.where(follower_id: params[:id])
    
    p @following_users = Array.new
    
    followingall.each do |following|
      p @following_users << User.find_by(id: following.followed_id)
    end    
  end
  
  def follower
    p @user = User.find(params[:id])
    followerall = Relationship.where(followed_id: params[:id])
    p followerall
    
    p @follower_users = Array.new
    
    followerall.each do |follower|
      p @follower_users << User.find_by(id: follower.follower_id)
    end    
    p @follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :address, :location, :password,
                                 :password_confirmation)
  end
  
  def authenticate_user!
    # current_userが@userでない時はroot_pathなどにリダイレクト
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path
    end  
  end

end
