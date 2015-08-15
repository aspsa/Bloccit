class PostsController < ApplicationController
  def index
    # Checkpoint #33 - CRUD
    #
    # "To show dynamic data from the Bloccit database, you'll need to modify
    # the 'index' method in 'post_controller.rb'. In the 'posts_controller.rb',
    # add the following to the 'index' method."
    @posts = Post.all
  end

  def show
    # "...before we update the view, let's go back to 'posts_controller.rb" and
    # update the 'show' method:"
    #
    # The 'show' method declares an instance variable names '@post' and assigns
    # it to the return of 'Post.find(params[:id])'. As you saw before, the
    # 'find' method is an Active Record method that takes an object 'id' as an
    # argument.
    #
    # "The 'PostsController' does not automatically know which post a user
    # clicked. This information has to be extracted from the request made when
    # the link was clicked. Rails controllers parse this request information
    # into a 'params' hash available in the controller and its associated
    # views."
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params.require(:post).permit(:title, :body))
    
    # The 'raise' method can serve as a useful debugging tool to view
    # the 'params' hash.
    # raise # This will short-circuit the method
    
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the poast. Please try again."
      render :edit
    end
  end
end