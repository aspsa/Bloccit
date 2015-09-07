# Assignment #40 - Topics and Posts
#
# Create Summary views to create and show post summaries
class SummariesController < ApplicationController
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @summary = Summary.new
    authorize @summary
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @summary = Summary.new(params.require(:summary).permit(:name, :description, :public))
    authorize @summary
    
    if @summary.save
      redirect_to [@topic, @post, @summary], notice: "Summmary was saved successfully."
    else
      flash[:error] = "Error creating summary. Please try again."
      render :new
    end
  end

  def show
    @summary = Summary.find(params[:id])
    @post = Post.find(params[:post_id])
    @topic = Topic.find(params[:topic_id])
    authorize @summary
  end
end
