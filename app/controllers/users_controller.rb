class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favorites_blog = @user.favorite_blog
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :image, :image_cache, :password,
                                 :password_confirmation)
  end
end