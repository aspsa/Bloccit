# Checkpoint #40 - Topics and Posts
#
# Update 'post.rb' and 'topic.rb' to reflect the
# 'topic_id' association.
class Post < ActiveRecord::Base
    has_many :comments
    belongs_to :user
    
    # Checkpoint #40 - Topics and Posts
    belongs_to :topic
    
    # Assignment #44 - Uploading Images
    #
    # Dalibor's Comment:
    #   Modify Post to mountuploader for the image attribute.
    mount_uploader :image, ImageUploader
    
    # Checkpoint #38 - Associations
    default_scope { order('created_at DESC') }
    
    # Checkpoint #42 - Validating Posts
    #
    # Validate the Post model with the following rules:
    #   A Post must have at least five characters in the title;
    #   A Post must have at least 20 characters in the body;
    #   A Post must have an associated topic and user.
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :topic, presence: true
    validates :user, presence: true
end