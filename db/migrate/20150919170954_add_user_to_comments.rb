# Checkpoint #46 - Comments
#
# Comments must be associated with users, so add a 'user_id' foreign key to the
# comments table. Remember to add an index to it, too.
class AddUserToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    add_index :comments, :user_id
  end
end
