class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update]
before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end 

  def create
    @user = User.new(user_params)
  
    if @user.save
     
      session[:user_id] = @user.id 
      flash[:notice] = "Weclome #{@user.user_name}, you have registered and logged in successfully"
      redirect_to root_path

      else  
      render 'new'
      end 

  end 

  def update

      if @user.update(user_params)
     
      session[:user_id] = @user.id 
      flash[:notice] = "#{@user.user_name}, your profile has been updated"
      redirect_to root_path

      else  
      render 'edit'
      end 

  end 

  def edit; end 

  def show; end 

  def user_params
    params.require(:user).permit(:user_name, :password)  
  end

  def set_user
    @user = User.find(params[:id])
  end 

  def require_same_user
    if current_user != @user
      flash[:error] = "You do not have permisions to edit a user other than yourself"
      redirect_to root_path
    end 
  end 

end 