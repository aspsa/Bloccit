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
end
