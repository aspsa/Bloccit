require 'faker'

# Create Posts
50.times do
    Post.create!(
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph
    )
end

Post.create!(
    title: "Unique Post",
    body: "The Checkpoint #32 ('Seed Data') assignment tasks one to add a unique
    post to the existing database in order to test the Idempotence principle."
)

posts = Post.all

# Create Commments
100.times do
    Comment.create!(
        post: posts.sample,
        body: Faker::Lorem.paragraph
    )
end

Comment.create!(
    body: "The Checkpoint #32 ('Seed Data') assignment tasks one to add a unique
    comment to the existing database in order to test the Idempotence
    principle."
)

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"