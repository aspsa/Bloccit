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
    
    # Checkpoint #60 - Testing Users
    #
    # With our (FactoryGirl) factories in place, it will be much easier to test the top_users method.
    describe ".top_rated" do
        before do
            @user1 = create(:user)
            post = create(:post, user: @user1)
            create(:comment, user: @user1, post: post)
            
            @user2 = create(:user)
            post = create(:post, user: @user2)
            2.times { create(:comment, user: @user2, post: post) }
        end
        
        it "returns users ordered by comments + posts" do
            expect( User.top_rated ).to eq([@user2, @user1])
        end
        
        it "stores a 'posts_count' on users" do
            users = User.top_rated
            expect( users.first.posts_count ).to eq(1)
        end
        
        it "stores a 'comments_count' on users" do
            users = User.top_rated
            expect( users.first.comments_count ).to eq(2)
        end
    end
    
    # Assignment #60 - Testing Users
    #
    #   - Read the Factory Girl getting started guide.
    #
    #   - Make a user_with_post_and_comment factory in the spec/factories/user.rb file.
    #
    #   - Define the factory within the factory :user definition, so you don't have to repeat most of the attribute definitions.
    #       -- Because of the direction of associations, comments and posts have
    #          user IDs, not the other way around. Therefore, use an after
    #          (:build).
    #
    #   - Use the user_with_post_and_comment factory in your users specs.
 
end