class PostsController < ApplicationController
  # Checkpoint #40 - Topics and Posts
  #
  # From 'routes.rb':
  #     However, these are commented out in favor of the shortcut that follows.
  #     resources :topics
  #     By calling 'resources :posts' in the 'resources :topics' block, you are
  #     instructing Rails to create nested routes. Review your new routes by
  #     running 'rake routes | grep post'.
  #
  #     resources :topics do
  #       resources :posts, except: [:index]
  #     end
  #
  # You may notice that there's no long a Post route for 'index'. This is
  # because the 'posts/index.html.erb' is no longer needed. All posts will be
  # displayed with respect to a Topic now, so 'posts#index' serves no purpose.
  # Remove the 'index' action from the 'posts_controller.rb', and delete
  # 'app/views/posts/index.html.erb'. You can remove it and stage the removal
  # at once by typing 'git rm app/views/posts/index.html.erb'.
  #
=begin  
  #def index
    # Checkpoint #33 - CRUD
    #
    # "To show dynamic data from the Bloccit database, you'll need to modify
    # the 'index' method in 'post_controller.rb'. In the 'posts_controller.rb',
    # add the following to the 'index' method."
    @posts = Post.all
    
    # Checkpoint #39 - Authorization
    authorize @posts
  end
=end

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
    
    # Checkpoint #40 - Topics and Posts
    #
    # In 'app/views/posts/show.html.erb' we have the statement
    #
    #     '<%= link_to "Edit", edit_topic_post_path(@topic, @post), class: 'btn btn-success' %>'
    #
    # '@topic' is being used to generate a valid URL, but that variable does
    # not exist yet in this view. We add the '@topic' variable here.
    @topic = Topic.find(params[:topic_id])
  end
  
  def create
    # Checkpoint #40 - Topics and Posts
    @topic = Topic.find(params[:topic_id])
    
    @post = Post.new(params.require(:post).permit(:title, :body))
    
    # Checkpoint #38 - Associations
    @post.user = current_user
    
    # Checkpoint #40 - Topics and Posts
    @post.topic = @topic
    
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
      
      # Checkpoint #40 - Topics and Posts
      #
      # redirect_to @post
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def new
    # Checkpoint #40 - Topics and Posts
    @topic = Topic.find(params[:topic_id])
    
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
    # Checkpoint #40 - Topics and Posts
    @topic = Topic.find(params[:topic_id])
    
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
    @topic = Topic.find(params[:topic_id])
    
    # Checkpoint #39 - Authorization
    #
    # Call authorize after the objects you've authorized have been defined.
    authorize @post
    
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
end
