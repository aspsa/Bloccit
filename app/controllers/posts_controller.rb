class PostsController < ApplicationController
  def index
    # Checkpoint #33 - CRUD
    #
    # "To show dynamic data from the Bloccit database, you'll need to modify
    # the 'index' method in 'post_controller.rb'. In the 'posts_controller.rb',
    # add the following to the 'index' method."
    
    # Assignment #39 - Authoriation
    #@posts = Post.all
    @posts = policy_scope(Post)
    
    # Checkpoint #39 - Authorization
    authorize @posts
  end

  def show
    # Checkpoint #33 - CRUD
    #
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
  
  def create
    @post = Post.new(params.require(:post).permit(:title, :body))
    
    # Checkpoint #38 - Associations
    @post.user = current_user
    
    # Checkpoint #39 - Authorization
    # 
    # We need to restrict 'posts#create', for when the 'posts#new' form is
    # submitted. We use 'authorize()' to check restrictions on the '@post'
    # about to be saved.
    authorize @post
    
    # Checkpoint #35 - More CRUD
    # raise # This will short-circuit the method
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def new
    @post = Post.new
    
    # Checkpoint #39 - Authorization
    #
    # 'authorize()' will check the policy on new post resources. If it's
    # satisfied (in this case, if a user is present), it will let the
    # rendering continue. If not (if no user is present), it'll throw an
    # exception.
    #
    # We have access to this 'authorize' method because we included 'Pundet'
    # in 'ApplicationController', from which the 'PostController' inherits.
    authorize @post
  end

  def edit
    # Checkpoint #35 - More CRUD
    @post = Post.find(params[:id])
    
    # Checkpoint #39 - Authorization
    #
    # Call authorize after the objects you've authorized have been defined.
    authorize @post
  end
  
  def update
    # Checkpoint #35 - More CRUD
    @post = Post.find(params[:id])
    
    # Checkpoint #39 - Authorization
    #
    # Call authorize after the objects you've authorized have been defined.
    authorize @post
    
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
end
