class User < ActiveRecord::Base
  # Checkpoint #36 - User Authentication
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Checkpoint #38 - Associations         
  has_many :posts
  
  # Checkpoint #39 - Authorization
  def admin?
    role == 'admin'
  end
  
  def moderator?
    role == 'moderator'
  end
end
