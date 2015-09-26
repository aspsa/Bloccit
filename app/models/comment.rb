class Comment < ActiveRecord::Base
  belongs_to :post
  
  # Checkpoint #46 - Comments
  #
  # Model changes:
  #   - Update the User model so you can call 'user.comments', and the 'Comment'
  #     model so you can call 'comment.user'.
  belongs_to :user
  
  # Checkpoint #46 - Comments
  #
  # View changes:
  #   - Add validations to the 'Comment' model so that comments are at least 5
  #     characters, and the 'body' and 'user_id' are always present.
  validates :body, length: { minimum: 5 }, presence: true
  validates :user_id, presence: true
end
