# Checkpoint #53 - Voting
#
# Create a Vote model with attributes for value (an integer), 'user_id' and 'post_id'.
#
# Hint: Use 'user:references' and 'post:references' in your generator to add the IDs and the relevant relationships in the model files.
class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
