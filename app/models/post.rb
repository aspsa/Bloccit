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
    
    # Checkpoint #55 - Favoriting
    #
    # Associate the Favorite model by adding has_many to the User and Post models. Remember that an instance of favorite cannot exist without an associated user or post, so add the dependent: :destroy option for both models.
    has_many :favorites, dependent: :destroy
    
    # Checkpoint #38 - Associations
    #default_scope { order('created_at DESC') }
    #
    # Checkpoint #53 - Voting
    #
    # Now that we have a rank that's determined by an algorithm, we'll employ it in the default_scope, so that posts are ordered by rank by default. Since we want the largest rank numbers displayed first, we'll use descending (DESC) order. Update the current default_scope declaration with 'rank DESC'
    default_scope { order('rank DESC') }
    
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
    #
    # Add the following 'up_votes' method to your post.rb file.
    # Remember 'votes' in this code is an implied 'self.votes'.
    #
    # Before continuing, add a similar 'down_votes' method to 'post.rb', and a 'points' method, which uses ActiveRecord's 'sum' method to add up the value of all the given post's votes.
    # You can pass a symbol of an attribute to sum, to tell it what to sum in the collection.
    
    # Checkpoint #54 - Mocking with RSpec
    #
    # The specs pass, but we've forgotten something. To get the specs to pass, we removed our validations for the presence of a topic and user for every post. Add those validations back.
    #
    # Run the specs again. They will fail, because our post won't save without a user and a topic. Our stub avoided the superficial "implementation" detail, and so skipped the fundamental problem. Let's try to solve these test errors using factories instead. In RSpec, a factory is a tool for generating particular types of objects for tests. There are great tools for test factories, such as the FactoryGirl gem, which we'll introduce later. For now, we'll build our own.
    validates :topic, presence: true
    validates :user, presence: true
    
    def up_votes
        votes.where(value: 1).count
    end
    
    def down_votes
        votes.where(value: -1).count
    end
    
    def points
       votes.sum(:value) 
    end
    
    # Checkpoint #53 - Voting
    #
    # The 'after_save' method will run update_post every time a vote is saved. The 'update_post' method calls a method named 'update_rank' on a vote's post object. We haven't created 'update_rank' yet, so 'open post.rb' and do that now.
    #
    # Note the two uses of implied 'self' -- 'created_at' and 'update_attribute'.
    #
    # People have very different takes on ranking algorithms. Some are very complex and some are very simple. The Bloccit algorithm is an attempt at a simple yet useful ranking tool. Since you created the rank attribute as a float, you'll have the flexibility needed to tinker with it. Try searching for the ranking algorithms that Hacker News or Reddit use.
    def update_rank
       age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
       new_rank = points + age_in_days
       
       update_attribute(:rank, new_rank)
    end
    
    # Assignment #53 - Voting
    #
    # It's safe to assume that if a user submits a post, they'll want to vote it up.
    #
    # Implement an 'after_create' method for Post. This method will create a new vote for the post on which it's called, associated with both the post and the user who created it.
    #
    # Call the 'after_create' method 'create_vote' and make it private.
    #
    # Checkpoint #54 - Mocking with RSpec
    #
    # Instead of calling create_vote as an after-create, which "implicitly" turns Post.create into Post.create_with_vote, explicitly call create_vote after saving a post in our app.
    #
    # The first step is to remove the call to after_create, and move create_vote out of private, so we can call it directly.
    #
    #after_create :create_vote
    
    # Assignment #53 - Voting
    #
    # It's safe to assume that if a user submits a post, they'll want to vote it up.
    #
    # In create_vote, use 'user.votes.create', and set the post association to equal 'self', and the value to equal '1'.
    #
    # If you get stuck, refer to the pattern of our 'after_save' method in 'vote.rb'.
    
    # Checkpoint #54 - Mocking with RSpec
    #
    # Instead of calling create_vote as an after-create, which "implicitly" turns Post.create into Post.create_with_vote, explicitly call create_vote after saving a post in our app.
    #
    # The first step is to remove the call to after_create, and move create_vote out of private, so we can call it directly.
    #
    #private
    
    def create_vote
        user.votes.create(value: 1, post: self)
    end
end