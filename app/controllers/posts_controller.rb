class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  
  def index
    if current_user
      @posts = Post.from_users_followed_by(current_user).recent
    end
  end
  
  def new
    @post = current_user.posts.new
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.new if current_user
  end
  
  def create
    @post = current_user.posts.new(post_params)
    
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      if @post.destroy
        redirect_to posts_path, notice: 'Post was successfully deleted.'
      else
        redirect_to @post, error: 'An error has occured while deleting the post.'
      end
    else
      redirect_to @post, error: 'You can only delete your own posts.'
    end
  end
  
  private
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
