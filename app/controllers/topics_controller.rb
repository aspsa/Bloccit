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
    @topics = Topic.paginate(page: params[:page], per_page: 10)
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