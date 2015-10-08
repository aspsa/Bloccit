class Comment < ActiveRecord::Base
  belongs_to :post
  
  # Checkpoint #46 - Comments
  #
  # Model changes:
  #   - Update the User model so you can call 'user.comments', and the 'Comment'
  #     model so you can call 'comment.user'.
  belongs_to :user
  
  # Checkpoint #55 - Favoriting
  #
  # When you want to do something every time something happens, it's a good candidate for a model callback. Since we want to send an email every time a comment is added to a favorited post, let's add a callback to comment.rb.
  after_create :send_favorite_emails
  
  # Checkpoint #46 - Comments
  #
  # View changes:
  #   - Add validations to the 'Comment' model so that comments are at least 5
  #     characters, and the 'body' and 'user_id' are always present.
  validates :body, length: { minimum: 5 }, presence: true
  validates :user_id, presence: true
  
  # Checkpoint #55 - Favoriting
  #
  # When you want to do something every time something happens, it's a good candidate for a model callback. Since we want to send an email every time a comment is added to a favorited post, let's add a callback to comment.rb.
  #
  # After a comment is created, we call send_favorite_emails. This method grabs the post, finds all of the favorites associated with it, and loops over them. For each favorite, it will create and send a new email.
  private
  
  def send_favorite_emails
    post.favorites.each do |favorite|
      FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
    end
  end
end