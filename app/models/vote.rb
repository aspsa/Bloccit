# Checkpoint #53 - Voting
#
# Create a Vote model with attributes for value (an integer), 'user_id' and 'post_id'.
#
# Hint: Use 'user:references' and 'post:references' in your generator to add the IDs and the relevant relationships in the model files.
class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end
