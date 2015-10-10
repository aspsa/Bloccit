class User < ActiveRecord::Base
  # Checkpoint #36 - User Authentication
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Checkpoint #38 - Associations         
  has_many :posts
  
  # Checkpoint #46 - Comments
  #
  # Model changes:
  #   - Update the User model so you can call 'user.comments', and the 'Comment'
  #     model so you can call 'comment.user'.
  #
  # Checkpoint #53 - Voting
  #
  # While the file is open, update 'user.rb' so that deleting a user record also destroys its associated posts and comments.
  #
  # has_many :comments
  has_many :comments, dependent: :destroy
  
  # Checkpoint #53 - Voting
  #
  # Votes have a similar relationship with users. Modify 'user.rb' to call the votes method on a user instance. This relationship will also destroy a user's votes when that user is destroyed.
  #
  # While the file is open, update 'user.rb' so that deleting a user record also destroys its associated posts and comments.
  has_many :votes, dependent: :destroy
  
  # Checkpoint #55 - Favoriting
  #
  # Associate the Favorite model by adding has_many to the User and Post models. Remember that an instance of favorite cannot exist without an associated user or post, so add the dependent: :destroy option for both models.
  has_many :favorites, dependent: :destroy
  
  # Checkpoint #44 - Uploading Images
  #
  # CarrierWave provides a method named mount_uploader which gives an attribute
  # additional functionality to assist in uploading. Declare mount_uploader in
  # user.rb.
  mount_uploader :avatar, AvatarUploader
  
  # Checkpoint #39 - Authorization
  def admin?
    role == 'admin'
  end
  
  def moderator?
    role == 'moderator'
  end
  
  # Checkpoint #55 - Favoriting
  #
  # The UI implementation for favorites should be simple. Essentially, we'll want to display a link on the posts#show view so that the user can flag that post as a favorite. Conversely, we'll want to display a link for users to unfavorite a post as well.
  #
  # To toggle between favorite and un-favorite states, it will be helpful to have a favorited method which will let us know if a given user has favorited a post. Go to user.rb and create the method.
  def favorited(post)
    favorites.where(post_id: post.id).first
  end
  
  # Checkpoint #57 - Another Interlude
  #
  # Open user.rb and add a voted method. Like the favorited method, voted should return whether the user has any votes for the post. If yes, it should return the vote; if not, nil.
  def voted(post)
    votes.where(post_id: post.id).first
  end
end