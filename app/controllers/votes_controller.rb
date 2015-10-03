# Checkpoint #53 - Voting
#
# There's no need to use the Rails controller generator, because we don't need any views associated with the 'votes_controller.rb'. Instead, create a new file in the 'app/controllers/'' directory and add the 'up_vote' method that you reference in 'routes.rb'.
#
# The method should find the relevant vote if one already exists for that post and the current_user. It should update the vote if it exists, and create a new one if not.
#
# You could implement a nearly identical method for down_vote, but that wouldn't be DRY. When you have separate methods with a lot of overlapping code, you should think of a DRYer way to write the methods. In this case, we'll use a 'before_action' to setup the instance variables needed for both 'up_vote' and 'down_vote'. Declare a 'before_action' at the top of 'votes_controller.rb', then define that private method.
#
# There's one other part of our old 'up_vote' method that was bothersome -- the conditional logic needed to either update or create a vote value. Let's extract that logic out into a separate method for updating vote values. By doing this, we keep 'up_vote' and 'down_vote' very simple. Add another private method named 'update_vote!'.
#
# Because we need to authorize an actual Vote object before it is saved to a database, the else section of the method has been expanded. Instead of a single call to create, the Vote object is first initialized with 'build', then authorized, and finally stored in a database using 'save'.
class VotesController < ApplicationController
    before_action :load_and_post_vote
    
    def up_vote
        #@post = Post.find(params[:post_id]) 
        #@vote = @post.votes.where(user_id: current_user_id).first

        #if @vote
        #    @vote.update_attribute(:value, 1)
        #else
        #    @vote = current_user.votes.create(value: 1, post: @post)
        #end

        update_vote!(1)

        # http://apidock.com/rails/ActionController/Base/redirect_to
        redirect_to :back
    end
    
    def down_vote
        update_vote!(-1)
        redirect_to :back
    end
    
    private
    
    def load_and_post_vote
        # Extract into this method the definition of '@post' and '@vote'.
        @post = Post.find(params[:post_id]) 
        @vote = @post.votes.where(user_id: current_user.id).first
    end
    
    def update_vote!(new_value)
       if @vote
           authorize @vote, :update?
           @vote.update_attribute(:value, new_value)
       else
           @vote = current_user.votes.build(value: new_value, post: @post)
           authorize @vote, :create?
           @vote.save
       end
    end
end