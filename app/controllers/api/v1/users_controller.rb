class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
    @user = User.all
  end

  def me
    render json: [current_user, current_user.scores]
  end

  def create
   @user = User.new(username: params[:username], password:params[:password])
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
