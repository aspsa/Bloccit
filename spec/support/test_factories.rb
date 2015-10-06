# Checkpoint #54 - Mocking with RSpec
#
# Let's create this directory and add a test_factories.rb file to it.
#
# Remove the two factories from spec/models/post_spec.rb, and add them to this file.
#
# Because we're removing the factories from post_spec.rb, we need to include the TestFactories module there as well. We should also replace our associated_post definition in vote_spec.rb. Follow the pattern of the votes_controller_spec above.
module TestFactories
    def associated_post(options={})
        post_options = {
            title: 'Post title',
            body: 'Post bodies must be pretty long.',
            topic: Topic.create(name: 'Topic name'),
            user: authenticated_user
        }.merge(options)
        
        Post.create(post_options)
    end
    
    def authenticated_user(options={})
        user_options = {email: "email#{rand}@fake.com", password: 'password'}.merge(options)
        user = User.new(user_options)
        user.skip_confirmation!
        user.save
        user
    end
end