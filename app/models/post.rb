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
    
    # Checkpoint #53 - Voting
    #
    # Modify post.rb to call post.votes. A Vote should not exist without a Post, so we need to account for posts being destroyed.
    #
    # We added similar code to 'ost.rb' for comments.
    has_many :votes, dependent: :destroy
    
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

    # Checkpoint #53 - Voting
    #
    # Because of Devise, however, creating a user for our test post isn't a trivial task, so don't add the code directly above. We'll discuss how to create a test user in the next checkpoint. For now, circumvent the issue by commenting the validations in post.rb.
    #
    # Here is the code that is suggested not to be added to 'post_spec.rb'.
    #
    #   before do
    #       user = User.create
    #       topic = Topic.create
    #       @post = Post.create(title: 'Post title', body: 'Post bodies must be
    #           pretty long.', user: user, topic: topic)
    #
    # validates :topic, presence: true
    # validates :user, presence: true
end