class PicturesController < ApplicationController
  before_action :set_picture, only: [:edit,:update,:destroy,:show]
  before_action :login_check, only: [:new,:edit, :show]
  
  def index
    @pictures = Picture.all
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end
  
  def destroy
    @picture.destroy
    redirect_to pictures_path
  end
  
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if @picture.save
      ContactMailer.contact_mail(@picture).deliver
      redirect_to pictures_path
      else
      render 'new'
    end
  end

  def show
     @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path
    else
      render 'edit'
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render :new if @picture.invalid?
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :image, :image_cache,
                                 :password_confirmation)
  end
    def picture_params
      params.require(:picture).permit(:title, :content, :image, :image_cache)
    end

    # idをキーとして値を取得するメソッド
    def set_picture
      @picture = Picture.find(params[:id])
    end

  def login_check
    unless current_user
      redirect_to new_session_path
    end

  def contact_params
      params.require(:contact).permit(:name, :email, :content, :image, :image_cache)
  end
  end
end
