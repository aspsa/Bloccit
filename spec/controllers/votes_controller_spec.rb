# Checkpoint #54 - Mocking with RSpec
#
# In keeping with our principle of testing low-level functionality as much as possible, however, let's address our next testing concern on the controller level. We want to make sure that our up-vote and down-vote buttons work as expected. To do this, we'll send test requests to the controller actions they hit and assert the response.
#
# Create a spec/controllers/votes_controller_spec.rb file, and add the following code.
require 'rails_helper'

describe VotesController do
    # Checkoint #54 - Mocking with RSpec
    #
    # Remove the two factories from spec/models/post_spec.rb, and add them to this file (i.e., spec/support/test_factories.rb).
    #
    # Because we're removing the factories from post_spec.rb, we need to include the TestFactories module there as well. We should also replace our associated_post definition in vote_spec.rb. Follow the pattern of the votes_controller_spec above.
    include TestFactories
    
    # Checkpoint #54 - Mocking with RSpec
    #
    # Dalibor's Comments:
    #   - You have a lot of errors in the checkpoint. This is how I fixed them.
    include Devise::TestHelpers
    
    # Checkpoint #54 - Mocking with RSpec
    #
    # We need to include the test helpers module that Devise provides. This module is called Devise::TestHelpers. Include it in the votes_controller_spec, just like we included TestFactories.
   
    describe '#up_vote' do
        it "adds and up vote to the post" do
            # Checkpoint #54 - Mocking with RSpec
            #
            # We need to set the request environment's HTTP_REFERER -- the record of where we just came from -- to stop our test from erroring when it hits the redirect_to :back in our controller. Because we don't care about the redirect here, let's just redirect to root.
            # Checkpoint #54 - Mocking with RSpec
            #
            # Dalibor's Comments:
            #   - You have a lot of errors in the checkpoint. This is how I fixed them.
            #request.env["HTTP_REFERRER"] = '/'
            request.env["HTTP_REFERER"] = '/'
            
            @user = authenticated_user
            @post = associated_post
            sign_in @user
            
            expect {
                post( :up_vote, post_id: @post.id )
            }.to change{ @post.up_votes }.by 1
        end
    end
end