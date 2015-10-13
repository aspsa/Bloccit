# Checkpoint #60 - Testing Users
#
# Let's create a Comment factory as well. Factory Girl lets us define after(:build) behavior for factories. Let's use this to disable the :send_favorite_emails callback because we don't want our tests to try to send emails.
#
# This code is run after the comment is initialized and before it's saved. This allows us the same opportunity to stub after-create behavior that we took advantage of in our manual factory.
FactoryGirl.define do
    factory :comment do
        body "This is a new comment."
        user
        post
        
        after(:build) do |comment|
            comment.class.skip_callback(:create, :after, :send_favorite_emails)
        end
    end
end