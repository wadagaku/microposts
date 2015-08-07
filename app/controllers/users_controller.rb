class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  def show 
     @user = User.find(params[:id])
    @microposts = @user.microposts
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
    @user = current_user
  end
  
  def update
     if @user.update(user_params)
          flash[:success] = "プロフィールを更新しました"
          redirect_to @user
      else
          render :edit
     end
  end
  
  
  
 



  def followings
    @followings = User.find(params[:id])
    @followings = @user.followings_users
    
  end
  
  
  def followers
    @followers = User.find(params[:id])
    @followers = @user.followers_users
     
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile)
  end
  
   def set_user
     if current_user.id == params[:id]
      @user = current_user
    else
    @user = User.find(params[:id])
     end
   end
end