require 'rails_helper'

describe Post do
    # Checkoint #54 - Mocking with RSpec
    #
    # Remove the two factories from spec/models/post_spec.rb, and add them to this file (i.e., spec/support/test_factories.rb).
    #
    # Because we're removing the factories from post_spec.rb, we need to include the TestFactories module there as well. We should also replace our associated_post definition in vote_spec.rb. Follow the pattern of the votes_controller_spec above.
    include TestFactories

    describe "vote methods" do
       before do
           # Checkpoint #53 - Voting
           #
           # The three tests below fail, because the Post's 'body' attribute value is not a minimum of twenty characters long. This is not evident in the RSpec error message, which simply states "You cannot call create unless the parent is saved." Tracing the error requires some digging. The following stament in the Post model provides the root cause of the RSpec error:
           #
           #        validates :body, length: { minimum: 20 }, presence: true
           #
           # @post = Post.create(title: 'post title', body: 'post body')
           #
           # Note: Checkpoint #53 - Voting implies that correcting the Post creation statement such that its 'body' attribute value passess the Post model's validation statement corrects this problem, although the RSpec validation test still fails for Votes.
           #
           #        "If you run the spec again, the validations for the
           #        presence of user and topic will also fail."
           #
           # Checkpoint #54 - Mocking with RSpec
           #
           # So how do we "stub" a user? Let's do so in the before block...
           #
           #@post = Post.create(title: 'post title', body: 'Post bodies must be pretty long.')
           #@post = Post.new(title: 'Post title', body: 'Post bodies must be pretty long.')

           # Checkpoint #54 - Mocking with RSpec
           #
           # Recall our testing principle, "Test what, not how." At its core, this principle means we should ignore as many extraneous details as possible, focusing our tests on exactly the functionality we care about. We shouldn't really care about how post creation works while we're testing up_votes, down_votes, and points. What we need is a way to skip that create_vote method entirely, so we neither have to stub out a user nor think about the method's effect on total votes.
           #
           # In the before block, we initialize a post, disable its create_vote method (by stubbing it with allow), and then save it.
           #
           #post_user = double(votes: @post.votes)
           #allow(@post).to receive(:user) { post_user }
           #
           # Checkpoint #54 - Mocking with RSpec
           #
           # Let's use the factory in our before block.
           #@post = Post.new(title: 'Post title', body: 'Post bodies must be pretty long.')
           #allow(@post).to receive(:create_vote)
           #@post.save
           @post = associated_post
           3.times { @post.votes.create(value: 1) }
           2.times { @post.votes.create(value: -1) }
       end
       
       describe '#up_votes' do
          it "counts the number of votes with value = 1" do
            expect( @post.up_votes ).to eq(3)
          end
       end
       
       describe '#down_votes' do
          it "counts the number of votes with value = -1" do
             expect( @post.down_votes ).to eq(2) 
          end
       end
       
       describe '#points' do
          it "returns the sum of all down and up votes" do
              expect( @post.points ).to eq(1)   # 3 - 2
          end
       end
       
       # Checkpoint #54 - Mocking with RSpec
       #
       # When create_vote was private and was never called explicitly, it didn't make sense to test it directly. Private methods should not be tested. Because private methods can't be called from outside an object, they're internal details by definition.
       #
       # Now that create_vote is public, however, it's a good idea to make sure it works, because we do call it directly in our app.
       #
       # The first expectation -- that the post starts with no upvotes -- only makes sense in relation to our recent changes. It's often not worth testing what doesn't happen, but in context, this overkill makes debatable sense.
       #
       # Our specs should now all pass.
       describe '#create_vote' do
          it "generates an up-vote when explicitly called" do
             post = associated_post
             expect( post.up_votes ).to eq(0)
             post.create_vote
             expect( post.up_votes ).to eq(1)
          end
       end
    end
    
    # Checkpoint #54 - Mocking with RSpec
    #
    # Run the specs again. They will fail, because our post won't save without a user and a topic. Our stub avoided the superficial "implementation" detail, and so skipped the fundamental problem. Let's try to solve these test errors using factories instead. In RSpec, a factory is a tool for generating particular types of objects for tests. There are great tools for test factories, such as the FactoryGirl gem, which we'll introduce later. For now, we'll build our own.
    #
    # Lets create a factory method in our post_spec. Define it below all the describe blocks.
    #
    # We're calling this a "factory" method, but it's just a regular Ruby method which returns a specific object.
    #def associated_post
    #   user = authenticated_user
    #   topic = Topic.create(name: 'Topic name')
    #   Post.create(title: 'Post title', body: 'Post bodies must be pretty long', topic: topic, user: user)
    #end
    #
    # Checkpoint #54 - Mocking wih RSpec
    #
    # Before we try our factories by running the specs, let's make them more flexible.
    #
    # Our new factories are helpful, but they're very rigid. What if we wanted to create a post with a particular body -- or user? To accommodate these possibilities, let's change our factories to accept a hash of options.
    #
    # The keys to these methods are the merge method and the default hash arguments that allow the two factories to be called without arguments.
    #
    # With these changes, we should be able to use our factories to quickly generate associated objects with as much or as little detail-orientation as we need.
    #
    # Checkoint #54 - Mocking with RSpec
    #
    # Remove the two factories from spec/models/post_spec.rb, and add them to this file (i.e., spec/support/test_factories.rb).
    #
    # Because we're removing the factories from post_spec.rb, we need to include the TestFactories module there as well. We should also replace our associated_post definition in vote_spec.rb. Follow the pattern of the votes_controller_spec above.
=begin
    def associated_post(options={})
       #user = authenticated_user
       #topic = Topic.create(name: 'Topic name')
       #Post.create(title: 'Post title', body: 'Post bodies must be pretty long', topic: topic, user: user)
       post_options = {
           title: 'Post title',
           body: 'Post bodies must be pretty long.',
           topic: Topic.create(name: 'Topic name'),
           user: authenticated_user
       }.merge(options)
       
       Post.create(post_options)
    end
=end

    # Checkpoint #54 - Mocking with RSpec
    #
    # We haven't yet defined the authenticated_user we refer to in our factory, however. Let's do that in another factory just below associated_post.
    #
    # Note two things about this last factory method:
    #   - The skip_confirmation! method is a Devise method that circumvents the
    #     need to fake email confirmation before creating an authenticated user.
    #     Devise also requires a password and a unique email (which is why we
    #     add a random number to the email).
    #   - Active Record's save method returns true or false, not the object
    #     saved. We have to end the authenticated_user method with user to
    #     return the new object.
    #def authenticated_user
    #   user = User.new(email: "email#{rand}@fake.com", password: 'password') 
    #   user.skip_confirmation!
    #   user.save
    #   user
    #end
    #
    # Checkpoint #54 - Mocking wih RSpec
    #
    # Before we try our factories by running the specs, let's make them more flexible.
    #
    # Our new factories are helpful, but they're very rigid. What if we wanted to create a post with a particular body -- or user? To accommodate these possibilities, let's change our factories to accept a hash of options.
    #
    # The keys to these methods are the merge method and the default hash arguments that allow the two factories to be called without arguments.
    #
    # With these changes, we should be able to use our factories to quickly generate associated objects with as much or as little detail-orientation as we need.
    #
    # Checkoint #54 - Mocking with RSpec
    #
    # Remove the two factories from spec/models/post_spec.rb, and add them to this file (i.e., spec/support/test_factories.rb).
    #
    # Because we're removing the factories from post_spec.rb, we need to include the TestFactories module there as well. We should also replace our associated_post definition in vote_spec.rb. Follow the pattern of the votes_controller_spec above.
=begin   
    def authenticated_user(options={})
       #user = User.new(email: "email#{rand}@fake.com", password: 'password') 
       user_options = {email: "email#{rand}@fake.com", password: 'password'}.merge(options)
       user = User.new(user_options)
       user.skip_confirmation!
       user.save
       user
    end
=end
end