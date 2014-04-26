class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_user, only: [:show, :follow, :unfollow, :block, :unblock]
  
  def index
    @users = User.all
  end
  
  def show
  end
  
  def follow
    current_user.follow!(@user)
    respond_with_ajax
  end

  def unfollow
    current_user.unfollow!(@user)
    respond_with_ajax
  end

  def block
    current_user.block!(@user)
    respond_with_ajax
  end

  def unblock
    current_user.unblock!(@user)
    respond_with_ajax
  end

  private
  
  def find_user
    @user = User.find(params[:id])
  end
end
