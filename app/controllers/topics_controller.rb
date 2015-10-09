# Checkpoint #40 - Topics and Posts
#
# The Topics controller file was created by executing the following statement
# in the IRB:
#     'rails g controller topics index new show edit'
#
# The auto-generated stubs are filled in; the 'create' and 'update' methods
# are added next.
class TopicsController < ApplicationController
  def index
    # Checkpoint #45 - Pagination
    #
    # Before we begin, think about where you might start implementing
    # 'will_paginate'. You know that the goal is to separate out the collections
    # of topics and posts, so we should start where we collect topics and posts
    # for display.
    #
    # We call paginate on the collection of posts and topics, and pass it some
    # arguments that will dictate how the pagination will eventually render. In
    # this case, we instruct paginate to select a subset of 10 posts / topics
    # per page, starting on page number params[:page].
    #
    # @topics = Topic.all
    #
    # Checkpoint #56 - Private Topics
    #
    # For our scope to modify the list of topics a user can see, modify the index method in topics_controller.rb to return a scoped collection of topics, rather than a comprehensive collection.
    #
    # Notice how we can chain our visible_to scope like any other method. We are not only passing in the current_user, but we are also keeping the collection paginated. This is possible because the scope returns an Active Record relation.
    #
    #@topics = Topic.paginate(page: params[:page], per_page: 10)
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    
    authorize @topics
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def show
    @topic = Topic.find(params[:id])
    
    # Checkpoint #40 - Topics and Posts
    #
    # To access the associated posts, we'll need to load that model data from
    # our controller. Update 'topics_controller.rb' and provide a '@posts'
    # variable that has been scoped for '@topic'.
    
    # Checkpoint #45 - Pagination
    #
    # @posts = @topic.posts
    @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
    authorize @topic
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end
  
  def create
    # Assignment #41 - Interlude
    #
    # Apply DRY.
    # @topic = Topic.new(params.require(:topic).permit(:name, :description, :public))
    @topic = Topic.new(topic_params)
    authorize @topic
    
    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end
  
  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    
    # Assignment #41 - Interlude
    #
    # Apply DRY.
    #
    # if @topic.update_attributes(params.require(:topic).permit(:name, :description, :public))
    if @topic.update_attributes(topic_params)
      redirect_to @topic
    else
      flash[:error] = "Error saving topic. Please try again."
      render :edit
    end
  end
  
  # Checkpoint #51 - Destroy
  #
  # You know that destroy is a CRUD action, so that should give you a clue on where to start coding. CRUD actions are written in controllers, so let's start by writing a destroy action in TopicsController.
  #
  # Note that we don't have to make any changes to routes.rb, because resources :topics sets up the routes for all CRUD actions for us.
  #
  # Before reading our code, see if you can write the action on your own. It should:
  #   - Find the topic by id.
  #   - Call authorize to make sure the topic can be destroyed by the current
  #     user.
  #   - Call destroy on the topic, and handle both success and failure with
  #     useful "flash messages".
  def destroy
    @topic = Topic.find(params[:id])
    
    authorize @topic
    
    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\"   was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting this topic."
      render :show
    end
  end
  
  # Assignment #41 - Interlude
  #
  # Let's clean up TopicsController in the same way we refactored PostsController.
  #   Create a private topic_params method in TopicsController.
  #   Refactor the create and update methods to use the topic_params method.
  private
  
  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end
end