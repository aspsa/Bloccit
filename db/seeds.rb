require 'faker'

# Checkpoint #38 - Associations
# Create Users
5.times do
    user = User.new(
        name:        Faker::Name.name,
        email:       Faker::Internet.email,
        password:    Faker::Lorem.characters(10)
    )
    
    user.skip_confirmation!
    user.save!
end

users = User.all

# Checkpoint #40 - Topics and Posts
#
# Create Topics
#
# Mentor feedback:
#   Seeds are not OK. You use topics when creating posts, so you should define
#   topics first.
#
# Note: Commented out below and moved here.
15.times do
    Topic.create!(
        name:           Faker::Lorem.sentence,
        description:    Faker::Lorem.paragraph
    )
end

topics = Topic.all

# Note: By calling 'User.new' instead of 'create', we create an instance
#       of User which isn't immediately saved to the database.

# The 'skip_confirmation!' method sets the 'confirmed_at' attribute to
# avoid triggering a confirmation email when the User is saved.

# The 'save!' method then saves this User to the database.

# Create Posts
50.times do
    Post.create!(
        # Checkpoint #38 - Associations
        user: users.sample,
        
        # Checkpoint #40 - Topics and Posts
        topic: topics.sample,
        
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph
    )
end

posts = Post.all

# Create Commments
100.times do
    Comment.create!(
        # Checkpoint #38 - Associations
        # user: users.sample,   # We have not yet associated Users with Comments
        
        post: posts.sample,
        body: Faker::Lorem.paragraph
    )
end

# Checkpoint #38 - Associations
# Checkpoint #39 - Authorization, commented out
#user = User.first
#user.skip_reconfirmation!
#user.update_attributes!(
#    email: '123aspsa123@gmail.com',
#    password: '!@TimISoarA11916'
#)

# Checkpoint #39 - Authorization
#
# Add a few special users to 'seeds.rb'. We can use these users to test
# different authorization levels.
#
# Create an admin user
admin = User.new(
    name:       'Admin User',
    email:      'admin@example.com',
    password:   'helloworld',
    role:       'admin'
)

admin.skip_confirmation!
admin.save!

# Create a moderator
moderator = User.new(
    name:       'Moderator User',
    email:      'moderator@example.com',
    password:   'helloworld',
    role:       'moderator'
)

moderator.skip_confirmation!
moderator.save!

# Create a member
member = User.new(
    name:       'Member User',
    email:      'member@example.com',
    password:   'helloworld'
)

member.skip_confirmation!
member.save!

# Checkpoint #40 - Topics and Posts
#
# Create Topics
#
# Mentor feedback:
#   Seeds are not OK. You use topics when creating posts, so you should define
#   topics first.
#
# Note: Move the following could higher up in this file under 'Create Users'
# 15.times do
#    Topic.create!(
#        name:           Faker::Lorem.sentence,
#        description:    Faker::Lorem.paragraph
#    )
# end

topics = Topic.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"