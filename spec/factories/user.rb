# Checkpoint #60 - Testing Users
#
# Since you will be creating multiple users with slightly different information, let's create a user factory with FactoryGirl. Create spec/factories/user.rb and add the below.
#
# This factory will generate a unique email for each user and mark them as confirmed_at, bypassing Devise's confirmation. You can use it in your specs:
#
#       build(:user) # Initialize but do not save
#       create(:user) # Build and save to test database
#       create(:user, name: 'Other Name') # Try it
#
# Because the number interpolated into emails is random, if you see the error below, just run the tests again.
#
# For more information, read Factory Girl's Getting Started documentation.
#
#  1) User.top_rated should return users based on comments + posts
#     Failure/Error: @user1 = create(:user) do |user|
#     ActiveRecord::RecordInvalid:
#       Validation failed: Email has already been taken
FactoryGirl.define do
    factory :user do
        name "Douglas Adams"
        sequence(:email, 100) { |n| "person#{n}@example.com" }
        password "helloworld"
        password_confirmation "helloworld"
        confirmed_at Time.now
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
    #
    # Dalibor's comments:
    # 
    # I'll help you start with the first task (I suppose you read FG documentation). Try to finish others on your own.
    #
    # spec/factories/user.rb
    #
    # FactoryGirl.define do
    #   factory :user do
    #       name "Douglas Adams"
    #       sequence(:email, 100) { |n| "person#{n}@example.com" }
    #       password "helloworld"
    #       password_confirmation "helloworld"
    #       confirmed_at Time.now
    #
    #       factory :user_with_post_and_comment do
    #           after(:build) do |user|
    #               post = create(:post, user: user)
    #               comment = create(:comment,  user: user, post: post)    
    #           end
    #       end
    #   end
    # end
    #
    # factory :user_with_post_and_comment, class: User do
    #    name "John Q. Public"
    #    sequence(:email, 50) { |n| "factory_person#{n}@example.com" }
    #    password "123"
    #    password_confirmation "123"
    #    confirmed_at Time.now
    #    
    #    after(:build) { |user, user_with_post_and_comment| user.top_rated }
    # end
    factory :user_with_post_and_comment do
        after(:build) do |user|
            post = create(:post, user: user)
            comment = create(:comment, user: user, post: post)
        end
    end
end