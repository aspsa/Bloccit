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
    
    # Assignment #58 - Public Profiles
    #
    # At the end of this checkpoint, we uncovered an error. To ensure it doesn't happen again write a second spec in profiles_spec.rb to test a user visiting their own profile.
    #
    # The spec's expectations (inside the it block) should be identical to those for the "not signed in" case.
    #
    # The spec should have an additional before block in which @user is signed in before visiting their profile page.
    #   - You should not need to make any changes outside of the spec folder.
    #
    # Do not use Devise::TestHelpers to sign in your user. They don't work in feature specs. Instead, read How To: Test with Capybara and follow the instructions to include the test helpers from Warden, the authentication framework on which Devise is built.
    #
    # After including the helpers and starting Warden in test mode, login_as your authenticated user in a before block.
    #
    # Give login_as a second argument of scope: :user, as per the article's instructions.
    #
    # Once you've successfully signed in the user, run profiles_spec.rb to confirm your new test passes.
    describe "signed in" do
        it "shows profile" do
            user = FactoryGirl.create(:user)
            login_as(user, :scope => :user)
            
            expect(current_path).to eq(user_path(@user))
            
            expect( page ).to have_content(@user.name)
            expect( page ).to have_content(@post.title)
            expect( page ).to have_content(@comment.body)
        end
    end
end