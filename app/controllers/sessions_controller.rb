class SessionsController < ApplicationController
  def new
  end 

  def create
  user = User.find_by(user_name: params[:username])


    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      flash[:notice] = "Weclome #{user.user_name}, you have logged in successfully"
      redirect_to root_path

    else 
    flash[:error] = "Username or Password is incorrect"
    render 'new'
    end 
  end 

  def destroy
    session[:user_id] = nil 
    flash[:notice] = "You have logged out"
    redirect_to root_path
  end 


end 
