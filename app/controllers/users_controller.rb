class UsersController < ApplicationController

  def show
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
    # p re1 = Relationship.create(follower_id: 1, followed_id: 2)
    # p re2 = Relationship.create(follower_id: 1, followed_id: 3)
    followingall = Relationship.where(follower_id: params[:id])
    
    p @following_users = Array.new
    
    followingall.each do |following|
      p @following_users << User.find_by(id: following.followed_id)
    end    
  end
  
  def follower
    p @user = User.find(params[:id])
    # p re1 = Relationship.create(follower_id: 2, followed_id: 1)
    # p re2 = Relationship.create(follower_id: 3, followed_id: 1)
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
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

end
