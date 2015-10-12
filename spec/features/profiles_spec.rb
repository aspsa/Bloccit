# Checkpoint #58 - Public Profiles
#
# This is a good example for using a feature spec because we have a clear user story: "As a Visitor, I want to see users' information, posts, and comments on a profile page".
#
# The spec will lay out our expectations for this flow, and guide us through the process of building the functionality which satisfies those expectations.
require 'rails_helper'

describe "Visiting profiles" do
    include TestFactories
    
    before do
        @user = authenticated_user
        
        # Checkpoint #58 - Public Profiles
        #
        # Our user flow states that the visitor should see the user's "information, posts, and comments." Let's add these expectations to the spec.
        @post = associated_post(user: @user)
        
        # Checkpoint #58 - Public Profiles
        #
        # As you may recall, the 'send_favorite_emails' method in 'comment.rb' is called after_create and sends an email out to each approving user who has favorited the relevant post. It makes more sense to stub this after create in the before block of our spec.
        #
        #@comment = Comment.create(user: @user, body: "A Comment")
        @comment = Comment.new(user: @user, post: @post, body: "A Comment")
        allow(@comment).to receive(:send_favorite_emails)
        @comment.save!
    end
    
    describe "not signed in" do
        it "shows profile" do
            visit user_path(@user)
            expect(current_path).to eq(user_path(@user))
            
            # Checkpoint #58 - Public Profiles
            #
            # Our user flow states that the visitor should see the user's "information, posts, and comments." Let's add these expectations to the spec.
            expect( page ).to have_content(@user.name)
            expect( page ).to have_content(@post.title)
            expect( page ).to have_content(@comment.body)
        end
    end
end