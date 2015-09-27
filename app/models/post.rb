# Checkpoint #40 - Topics and Posts
#
# Update 'post.rb' and 'topic.rb' to reflect the
# 'topic_id' association.
class Post < ActiveRecord::Base
    # Checkpoint #51 - Destroy
    #
    # Just like with topics, think about the implications of deleting a post. You know that comments belong to to posts, so let's modify post.rb to handle this
    # Note that because comments are dependent on posts and posts are dependent on topics, if you delete a topic, it will remove its associated posts and those posts' associated comments.
    #
    # has_many :comments
    has_many :comments, dependent: :destroy
    belongs_to :user
    
    # Checkpoint #40 - Topics and Posts
    belongs_to :topic
    
    # Checkpoint #38 - Associations
    default_scope { order('created_at DESC') }
    
    # Checkpoint #42 - Validating Posts
    #
    # Validate the Post model with the following rules:
    #   A Post must have at least five characters in the title;
    #   A Post must have at least 20 characters in the body;
    #   A Post must have an associated topic and user.
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :topic, presence: true
    validates :user, presence: true
end