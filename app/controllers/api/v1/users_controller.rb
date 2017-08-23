class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
    @user = User.all
  end

  def me
    render json: current_user
  end

  def create
   @user = User.new(username: params[:user][:username], password:params[:user][:password])
   byebug
   if @user.save
     render json: @user
   else
     render json: { message: "User not created"}
   end

  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
