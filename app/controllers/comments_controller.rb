# Checkpoint #46 - Comments
#
# Controllers:
#   - Comments will only need to be created for now, so generate a
#     'comments_controller' with the appropriate action.
#   - Fill in the 'create' action. It should create a new comment, associated
#     with a post and the 'current_user' who created it.
class CommentsController < ApplicationController
  def create
    # Checkpoint #46 - Comments
    #
    # Fill in the 'create' action. It should create a new comment associated
    # with a 'post' and the 'current_user' who created it.
    #
    # Assignment #51 - Destroy
    #
    # Note the 'only: []'' in the top-level post resources line. This is because we don't want to create any '/posts/:id' routes, just 'posts/:post_id/comments'.
    #
    # Change the 'CommentsController' actions so that they no longer initialize '@topic'.
    #
    # Derive '@topic' from '@post' because we still want 'redirect_to' the '@post' page after creating or destroying a comment. Furthermore, '@post' is still nested under '@topic'.
    #
    # @topic = Topic.find(params[:topic_id])
    # @post = @topic.posts.find(params[:post_id])
    @post = Post.find(params[:post_id])

    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    
    # Checkpoint #40 - Topics and Posts
    # @comment.post.topic = @topic
    
    # Assignment #46 - Comments
    #
    # If you try to create a comment without first signing in, you'll encounter a no method 'id' for NilClass error. This error is thrown because current_user is nil when you're not signed in, and comment creation attempts to extract an id from this nil object.
    #   - Use CommentPolicy in PostsController and CommentsController to authorize your comments.
    authorize @comment
 
    # Checkpoint #35 - More CRUD
    # raise # This will short-circuit the method
    if @comment.save
      flash[:notice] = "Comment was saved."
      # Assignment #51 - Destroy
      #
      # Note the 'only: []'' in the top-level post resources line. This is because we don't want to create any '/posts/:id' routes, just 'posts/:post_id/comments'.
      #
      # Change the 'CommentsController' actions so that they no longer initialize '@topic'.
      #
      # Derive '@topic' from '@post' because we still want 'redirect_to' the '@post' page after creating or destroying a comment. Furthermore, '@post' is still nested under '@topic'.
      #
      #redirect_to [@topic, @post]
      redirect_to [@post, @comment]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :new
    end
  end
  
  # Checkpoint #51 - Destroy
  #
  # Open 'comments_controller.rb' and add the 'destroy' method below
  def destroy
    # Checkpoint #46 - Comments
    #
    # Fill in the 'create' action. It should create a new comment associated
    # with a 'post' and the 'current_user' who created it.
    #
    # Assignment #51 - Destroy
    #
    # Note the 'only: []'' in the top-level post resources line. This is because we don't want to create any '/posts/:id' routes, just 'posts/:post_id/comments'.
    #
    # Change the 'CommentsController' actions so that they no longer initialize '@topic'.
    #
    # Derive '@topic' from '@post' because we still want 'redirect_to' the '@post' page after creating or destroying a comment. Furthermore, '@post' is still nested under '@topic'.
    #
    # @topic = Topic.find(params[:topic_id])
    # @post = @topic.posts.find(params[:post_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    
    authorize @comment
    
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      # Assignment #51 - Destroy
      #
      # Note the 'only: []'' in the top-level post resources line. This is because we don't want to create any '/posts/:id' routes, just 'posts/:post_id/comments'.
      #
      # Change the 'CommentsController' actions so that they no longer initialize '@topic'.
      #
      # Derive '@topic' from '@post' because we still want 'redirect_to' the '@post' page after creating or destroying a comment. Furthermore, '@post' is still nested under '@topic'.
      #
      #redirect_to [@topic, @post]
      redirect_to [@post, @comment]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      redirect_to [@topic, @post]
    end
  end
    
  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end