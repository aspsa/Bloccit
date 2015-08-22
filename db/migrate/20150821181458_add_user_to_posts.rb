class AddUserToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer

    # Checkpoint #38 - Associations
    add_index :posts, :user_id
  end
end
