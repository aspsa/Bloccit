# Checkpoint #40 - Topics and Posts
#
# Update 'post.rb' and 'topic.rb' to reflect the
# 'topic_id' association.
class Topic < ActiveRecord::Base
    # Checkpoint #40 - Topics and Posts
    has_many :posts
    
    # Assignment #42 - Validating Posts
    #
    # In addition to validating posts, we should validate topics.
    #   Add a validation to ensure that Topic names are at least five characters
    #       long.
    validates :name, length: { minimum: 5 }, presence: truep.va
end
