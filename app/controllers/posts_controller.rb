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
  end

  def edit
  end
end
