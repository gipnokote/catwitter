class CommentsController < ApplicationController

  def create
    get_object
    @comment = @object.comments.create(comment: params[:comment][:comment], user: current_user)
    @comment = @object.comments.new
    respond_with_ajax
  end

  def destroy
    @comment = Comment.find(params[:id])
    params[:object_type] = @comment.commentable_type
    params[:object_id] = @comment.commentable_id
    @comment.destroy
    get_object
    respond_with_ajax
  end
  
  private
  
  def get_object
    case params[:object_type]
    when 'Post'
      object = Post
    end
    @object = object.find(params[:object_id])
  end

end
