# Checkpoint #53 - Voting
#
# Now that we have a way to create values for posts, we should leverage it to order posts more intelligently. We'll want to store the rank of a post, so let's add an attribute for it in the posts table.
#
# Note: we created the rank attribute as a float (decimal) to have greater flexibility with ranking algorithms later.
class AddRankToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :rank, :float
  end
end
