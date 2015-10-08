# Checkpoint #55 - Favoriting
#
# There are some new things in this spec:
#
#   - We use Active Record's find_by method to find a single favorite or return nil. Try it out with other attributes - user.find_by(email: 'whatever') - to learn what this method does.
#
#   - As with previous controller specs, RSpec knows what controller it's testing, so we don't need to specify a path. We just specify an action to "hit" in our test.
#
#   - We send a DELETE request to :destroy, because that is the action's associated HTTP verb.
#
#   - Note our module inclusions again. We need them for associated_post, authenticated_user, and sign_in.
require 'rails_helper'

describe FavoritesController do
    include TestFactories
    include Devise::TestHelpers
    
    before do
        @post = associated_post
        @user = associated_user
        sign_in @user
    end
    
    describe "#create" do
        it "creates a favorite for the current user and specified post" do
            expect( @user.favorites.find_by_post_id(@post.id) ).to be_nil
            post :create, { post_id: @post.id }
            expect( @user.favorites.find_by_post_id(@post.id) ).not_to be_nil
        end
    end
    
    describe "#destroy" do
        it "destroys the favorite for the current user and post" do
            favorite = @user.favorites.where(post: @post).create
            expect( @user.favorites.find_by_post_id(@post.id) ).not_to be_nil
            delete :destory, { post_id: @post.id, id: favorite.id }
            expect( @user.favorites.find_by_post_id(@post.id) ).to be_nil
        end
    end
end