class Post < ActiveRecord::Base
    has_many :comments
    
    # Checkpoint #38 - Associations
    belongs_to :user
    default_scope { order('created_at DESC') }
end