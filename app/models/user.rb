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
  has_many :comments
  
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
