# Checkpoint #40 - Topics and Posts
#
# We create an index on 'topic_id' in the generator.
# An index improves the speed of operations on a database
# table. You should always index your foreign key columns.
#
#   rails g migration AddTopicToPosts topic_id:integer:index
class AddTopicToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :topic_id, :integer
    add_index :posts, :topic_id
  end
end
