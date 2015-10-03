# Checkpoint #53 - Voting
#
# Create a Vote model with attributes for value (an integer), 'user_id' and 'post_id'.
#
# Hint: Use 'user:references' and 'post:references' in your generator to add the IDs and the relevant relationships in the model files.
class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  # Checkpoint #53 - Voting
  #
  # To get this test passing (and our functionality working as expected), add the following validation in 'vote.rb'.
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }
  
  # Checkpoint #53 - Voting
  #
  # We need to rank the posts after each vote is cast. This is a perfect opportunity to use an a'fter_save' callback. Open 'vote.rb' and add the following.
  #
  # The 'after_save' method will run 'update_post' every time a vote is saved. The 'update_post' method calls a method named 'update_rank' on a vote's post object.
  after_save :update_post
  
  private
  
  def update_post
    post.update_rank  # See the 'post.rb' model
  end
end