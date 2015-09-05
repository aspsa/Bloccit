# Checkpoint #40 - Topics and Posts
#
# Update 'post.rb' and 'topic.rb' to reflect the
# 'topic_id' association.
class Post < ActiveRecord::Base
    has_many :comments
    belongs_to :user
    
    # Checkpoint #40 - Topics and Posts
    belongs_to :topic
    
    # Checkpoint #38 - Associations
    default_scope { order('created_at DESC') }
end