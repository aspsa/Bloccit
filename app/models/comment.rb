class Comment < ActiveRecord::Base
  belongs_to :post
  
  # Checkpoint #46 - Comments
  #
  # Model changes:
  #   - Update the User model so you can call 'user.comments', and the 'Comment'
  #     model so you can call 'comment.user'.
  belongs_to :user
  
  # Checkpoint #62 - Creating with Ajax
  #
  # Since we are prepending comments to the top of the list (see 'app/views/comments/create.js.erg'), we should make sure that comments are always ordered consistently. For example, if we refresh the page after the Ajax response, we want the order to stay consistent. We can accomplish this by using a default_scope.
  #
  # Assignment #62 - Creating with Ajax
  #
  #   - Rather than attach new comments to the top of the list, attach them to the bottom. This will make Bloccit adhere to the conventions followed by most commenting systems.
  #
  #   - To attach new comments to the bottom of the list, use the jQuery append() method.
  #
  #   - Since we are now appending comments to the bottom of the list, reverse the default_scope in comment.rb so that comments are now returned in ascending order by their updated date.
  #
  #default_scope { order('updated_at DESC') }
  default_scope { order('updated_at ASC') }
  
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
      # Checkpoint #57 - Another Interlude
      #
      # Open comment.rb, where the email is sent, and change the send_favorite_emails method to only send the email to users who have elected to follow favorite posts by email (and who didn't write the comment themselves).
      #
      #FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
      #
      # That if line is pretty long and unclear. Let's refactor it into a private method to make our logic clearer.
      #
      #if user_id != favorite.user_id && favorite.user.email_favorites?
      #  FavoriteMailer.new_comment(favorite.user, self.post, self).deliver_now
      #end
      if should_receive_update_for?(favorite)
        FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
      end
    end
  end
  
  def should_receive_update_for?(favorite)
    user_id != favorite.user_id && favorite.user.email_favorites?
  end
end