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
# -------------
# We also need to update 'seeds.rb', because none of the Posts in
# the database currently have an associated topic. Create some new
# topics first.
#
# (Note: I originally placed this code in the wrong part of this
# file. The 'seeds.rb' file is executed sequentially in line order.)
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
    # Checkpoint #53 - Voting
    #
    # Since we updated the posts table with a rank attribute, we should make sure it's properly seeded when we reset the database. Open 'seeds.rb' and add 'post.update_rank' to the section where we create posts.
    #
    #Post.create!(
    #
    post = Post.create!(
        # Checkpoint #38 - Associations
        user: users.sample,
        
        # Checkpoint #40 - Topics and Posts
        #
        # Modify the code that seeds posts to assign each post to a
        # random topic.
        topic: topics.sample,
        
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph
    )
    
    # Checkpoint #53 - Voting
    #
    # Set the 'create_at' to a time within the past year.
    post.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
    
    # Checkpoint #54 - Mocking with RSpec
    #
    # Anywhere we create a post, we must also call create_vote on it. Some simple text searching for Post.create and post.save returns two relevant results outside of our specs, the posts_controller and our seeds file.
    #
    # Checkpoint #58 - Public Profiles
    #
    # Dalibor's comment:
    #   - As I told you before default value for topics.public is not true but  nil. I added before_save method that sets default value to true and it solved problem. I also found error in seeds file and corrected it.
    #
    #@post.create_vote
    post.create_vote

    post.update_rank
end

posts = Post.all

# Create Commments
100.times do
    Comment.create!(
        # Checkpoint #38 - Associations
        # user: users.sample,   # We have not yet associated Users with Comments
        #
        # Checkpoint #46 - Comments
        #
        # Model changes:
        #   - Modify the 'seeds.rb' file to create valid comments when you run
        #     'db:reset'
        user: users.sample,

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