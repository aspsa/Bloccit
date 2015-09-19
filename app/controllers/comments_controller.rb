# Checkpoint #46 - Comments
#
# Controllers:
#   - Comments will only need to be created for now, so generate a
#     'comments_controller' with the appropriate action.
#   - Fill in the 'create' action. It should create a new comment, associated
#     with a post and the 'current_user' who created it.
class CommentsController < ApplicationController
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    authorize @comment
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comments_params)
    
    @comment.user = current_user
    
    # Checkpoint #40 - Topics and Posts
    @comment.post.topic = @topic
    
    authorize @comment
    
    # Checkpoint #35 - More CRUD
    # raise # This will short-circuit the method
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :new
    end
  end
    
  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end