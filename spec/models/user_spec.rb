# Checkpoint #55 - Favoriting
#
# Add the following specs to your app. Read them through to make sure you understand what they're testing.
require 'rails_helper'

describe User do
    include TestFactories
    
    describe "#favorited(post)" do
        # Checkpoint #55 - Favoriting
        #
        # Run the above specs, and they should show up as "pending", because of the xit syntax with which we declare the individual tests. Completing these tests will be your assignment for this checkpoint.
        #
        # Also, see 'http://stackoverflow.com/questions/27288775/how-to-ignore-or-skip-a-test-method-using-rspec'
        xit "returns 'nil' if the user has not favorited the post" do
        end
       
        xit "returns the appropriate favorite if it exists" do
        end
    end
end