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
    
    # Checkpoint #56 - Private Topics
    #
    # Scopes are additionally useful because they can be chained. Scopes are called on relations (Active Record collections), and return relations, so it's easy to select very precisely by simply chaining scopes. Active Record automatically combines all the conditions for you into one quick SQL query!
    #
    # This uses a lambda syntax (the arrow -> with a block) that is the proper way to pass a piece of code into a scope definition. This scope runs the code inside the lambda on the relation or class on which it's called. In other words, Topic.visible_to is equivalent to Topic.where(public: true).
    #
    # Checkpoint #56 - Private Topics
    #
    # This works, but it doesn't solve the problem of determining whether the topic is visible to a particular user. To do that using our scope as written, we would require an if statement in the topics_controller to determine if a user is signed-in. Instead, let's create a new scope the lambda of which takes an argument:
    #
    # Notice the usage of the ternary operator to keep the lambda on one line. This is essentially a one-line if-else condition. It's useful, but often involves sacrificing clarity for brevity.
    #
    #scope :visible_to, -> { where(public: true) }
    scope :visible_to, ->(user) { user ? all : where(public: true) }
    
    # Assignment #56 - Private Topics
    #
    # Define publicly_viewable and privately_viewable scopes on Topic that return collections of public or private topics.
    #
    # Use the publicly_viewable scope inside of the visible_to scope to make your code more DRY.
    #
    # Dalibor's Comment:
    #   - These scopes do not depend on user. Revise as follows:
    #
    #scope :publicly_viewable, ->(user) { user ? all : where(public: true) }
    #scope :privately_viewable, ->(user) { user ? all : where(public: false) }
    scope :publicly_viewable, -> { where(public: true) }
    scope :privately_viewable, -> { where(public: false) }
end
