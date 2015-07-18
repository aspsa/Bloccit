require 'faker'

# Create Posts
50.times do
    Post.create!(
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph
    )
end

# Mentor offered this efficient workaround created by a Bloc student
unique_post = {title: "Unique Post Title", body: "Unique post body"}
#
# See "http://apidock.com/rails/ActiveRecord/Relation/first_or_create"
# Post.where(unique_post).first_or_create
#
# http://apidock.com/rails/v4.0.2/ActiveRecord/Relation/first_or_create!
Post.where(unique_post).first_or_create!

posts = Post.all

# Create Commments
100.times do
    Comment.create!(
        post: posts.sample,
        body: Faker::Lorem.paragraph
    )
end

# Mentor offered this efficient workaround created by a Bloc student
unique_comment = {body: "Unique comment body"}
#
# See "http://apidock.com/rails/ActiveRecord/Relation/first_or_create"
# Comment.where(unique_comment).first_or_create
#
# # http://apidock.com/rails/v4.0.2/ActiveRecord/Relation/first_or_create!
Comment.where(unique_comment).first_or_create!

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"