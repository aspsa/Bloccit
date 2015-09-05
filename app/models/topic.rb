# Checkpoint #40 - Topics and Posts
#
# Update 'post.rb' and 'topic.rb' to reflect the
# 'topic_id' association.
class Topic < ActiveRecord::Base
    # Checkpoint #40 - Topics and Posts
    has_many :posts
end
