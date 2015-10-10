# Checkpoint #57 - Another Interlude
#
# We'll stick with the describe/it syntax we've been using, rather than switching to the equivalent feature/scenario syntax used in the above resource (i.e., Capybara).
#
# A feature spec tests behavior from a user's perspective, so unlike in our controller specs, we won't be including Devise's test helpers and signing users in using a method -- we'll be stepping through the user flow as if we were in a browser.
require 'rails_helper'

describe "Sign in flow" do
    include TestFactories
    
    describe "successful" do
        it "redirects to the topics index" do
            user = authenticated_user
            visit root_path
            
            # Checkpoint #57 - Another Interlude
            #
            # There are two links named "Sign In" on our page. Let's specify which one.
            #
            # We give within a class (.) or ID (#) argument, and a block to be executed within the HTML defined by that element. In this case, we've chosen the .user-info div in application.html.erb that surrounds our nav-bar login button.
            within '.user-info' do
                click_link 'Sign In'
            end
            fill_in 'Email', with: user.email
            fill_in 'Password', with: user.password
            
            within 'form' do
                click_button 'Sign in'
            end
            
            expect(current_path).to eq topics_path
        end
    end
end