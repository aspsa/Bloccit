# Assignment #40 - Topics and Posts
#
# Create Summary views to create and show post summaries
class SummariesController < ApplicationController
  def new
    @summary = Summary.new
    authorize @summary
  end

  def create
    @summary = Summary.new(params.require(:summary).permit(:name, :description, :public))
    authorize @summary
    
    if @summary.save
      redirect_to @summary, notice: "Summmary was saved successfully."
    else
      flash[:error] = "Error creating summary. Please try again."
      render :new
    end
  end

  def show
    @summary = Summary.find(params[:id])
    # @posts = @summary.posts
    @post = @summary.posts[:id]
    authorize @summary
  end
end
