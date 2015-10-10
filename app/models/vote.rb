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
  
  # Checkpoint #57 - Another Interlude
  #
  # Note the use of a ternary operator to keep our link_to methods one line long (see 'app/views/votes/_voter.html.erb'). Inside those ternary operators, we are calling up_vote and down_vote methods to determine if the voted class should be used to style the arrow. We did a bit of "wishful coding" here, as we used methods that didn't exist when we called them. Open vote.rb and add the methods.
  def up_vote?
    value == 1
  end
  
  def down_vote?
    value == -1
  end
  
  private
  
  def update_post
    post.update_rank  # See the 'post.rb' model
  end
end