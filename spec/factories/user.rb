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
end