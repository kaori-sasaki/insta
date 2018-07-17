class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit,:update,:destroy,:show]
  before_action :login_check, only: [:new,:edit, :show]
  
    def index
        @blogs = Blog.all
    end
    
    def new
      if params[:back]
          @blog = Blog.new(blog_params)
      else
          @blog = Blog.new
      end
        
    end
    
    def create
        @blog = Blog.new(blog_params)
        @blog.user_id = current_user.id
      if @blog.save
        redirect_to blogs_path, notice: 'ブログが作成されました'
      else
        render 'new'
      end
    end
    
    def show
       @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    end
    
    def edit
    end
    
    def update
    if @blog.update(blog_params)
        redirect_to blogs_path, notice: '編集しました'
    else
        render 'edit'
    end
    end
    
    def destroy
        @blog.destroy
        redirect_to blogs_path,notce: 'ブログを削除しました'
    end
    
    def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    render :new if @blog.invalid?  
    end
    
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
    def blog_params
      params.require(:blog).permit(:title, :content)
    end

    # idをキーとして値を取得するメソッド
    def set_blog
      @blog = Blog.find(params[:id])
    end

  def login_check
    unless current_user
      redirect_to new_session_path
    end
  end
end
