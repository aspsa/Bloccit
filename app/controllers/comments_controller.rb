# Checkpoint #46 - Comments
#
# Controllers:
#   - Comments will only need to be created for now, so generate a
#     'comments_controller' with the appropriate action.
#   - Fill in the 'create' action. It should create a new comment, associated
#     with a post and the 'current_user' who created it.
class CommentsController < ApplicationController
  def create
=begin
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
      
      # Assignment #51 - Destroy
      #
      # Dalibor's comment:
      #   - redirect_to [@post.topic, @post]
      #
      # redirect_to [@post, @comment]
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :new
    end
=end

    # Checkpoint #61 - Creating with Ajax
    #
    # We let you write your own create action in the Comments checkpoint. It may differ from ours, so rather than showing a diff, we'll just give you new code. Replace your code with the below.
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    
    @comment = Comment.new( comment_params )
    @comment.user = current_user
    @comment.post = @post
    
    # Checkpoint #61 - Creating with Ajax
    #
    # Create a new comment in your app. The unobtrusive create action should have worked, but you probably noticed a problem -- the form wasn't cleared after the create. To clear the form, we can render a new _form partial, with a new instance of a comment. We'll start by adding this new instance variable to the comments controller.
    @new_comment = Comment.new
    
    authorize @comment
    
    if @comment.save
      flash[:notice] = "Comment was created."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end
    
    respond_to do |format|
      format.html
      format.js
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
      
      # Assignment #51 - Destroy
      #
      # Dalibor's comment:
      #   - redirect_to [@post.topic, @post]
      #
      # redirect_to [@post, @comment]
      #
      # Checkpoint #60 - Destroying with Ajax
      #
      # Update the destroy action in the comments controller. Comment out the redirect_to statement.
      #
      #redirect_to [@post.topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      
      # Checkpoint #60 - Destroying with Ajax
      #
      # Update the destroy action in the comments controller. Comment out the redirect_to statement.
      #
      #redirect_to [@topic, @post]
    end
    
    # Checkpoint #60 - Destroying with Ajax
    #
    # Update the destroy action in the comments controller.
    #
    # The respond_to block gives our controller action the ability to return different response types, depending on what was asked for in the original request. The controller's response is unchanged if the client requests HTML, but if the client requests JavaScript, the controller will render .js.erb instead.  
    respond_to do |format|
      format.html
      format.js
    end
  end
    
  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end