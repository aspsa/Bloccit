# Checkpoint #60 - Testing Users
#
# Let's create a post factory.
FactoryGirl.define do
    factory :post do
        title "Post Title"
        body "Post bodies must be pretty long."
        user
        topic { Topic.create(name: 'Topic name') }
    end
end