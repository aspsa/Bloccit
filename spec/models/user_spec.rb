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
        
        # Assignment #55 - Favoriting
        #
        #   - Complete the user_spec.rb file we scaffolded at the beginning of the checkpoint.
        #
        #   - Keep your spec DRY by creating common objects in a before block inside of describe "#favorited(post)".
        #
        #   - Don't forget to change xit to it. Unless you do, your tests will be considered "pending" and won't be run.
        
        before do
            @user = authenticated_user  # From 'spec/support/test_factories.rb'
            @post = associated_post     # From 'spec/support/test_factories.rb'
        end
        
        #xit "returns 'nil' if the user has not favorited the post" do
        #end
        it "returns 'nil' if the user has not favorited the post" do
            expect( @user.favorited(@post) ).to be_nil
        end
       
        #xit "returns the appropriate favorite if it exists" do
        #end
        it "returns the appropriate favorite if it exists" do
            # Adapted from 'Favorites#create' ('controllers/favorites_controller.rb')
            favorite = @user.favorites.build(post: @post)
            favorite.save
            
            expect( @user.favorited(@post) ).not_to be_nil
        end
    end
end