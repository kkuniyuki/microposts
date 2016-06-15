class UsersController < ApplicationController
before_action :authenticate_user!, only: [:edit, :update]
  
  def show 
   @user = User.find(params[:id])
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
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
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
