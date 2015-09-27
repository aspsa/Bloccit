# Checkpoint #40 - Topics and Posts
#
# Update 'post.rb' and 'topic.rb' to reflect the
# 'topic_id' association.
class Topic < ActiveRecord::Base
    # Checkpoint #40 - Topics and Posts
    
    # Checkpoint #51 - Destroy
    # 
    # Before we test the delete, we need to think about the consequences. Posts belong to topics. If we delete a topic, the posts that belonged to it are left without parent topic.
    #
    # Always consider the consequences of deleting objects in your app. Deleting objects with associations can cause serious bugs. If you delete a post's user, for instance, any view that displays that post with its user's name will throw a no method 'name' for NilClass error.
    #
    # Fortunately, Rails has a nice way of handling this problem in the model layer. Open topic.rb and add the following to the has_many declaration
    #
    # This code will delete any dependent posts when a topic is deleted. Now you can restart your Rails server and test the deletion safely.
    #
    # has_many :posts
    has_many :posts, dependent: :destroy
end
