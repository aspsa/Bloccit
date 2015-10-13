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
#
# From 'https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara'
#   - You will then need to create a corresponding user factory in your factories file (e.g. spec/factories.rb, test/factories.rb).
FactoryGirl.define do
    factory :user do
        email 'test@example.com'
        password 'f4k3p455w0rd'
        
        # if needed
        # is_active true
    end
end