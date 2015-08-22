class Post < ActiveRecord::Base
    has_many :comments
    belongs_to :user
    
    # Checkpoint #38 - Associations
    default_scope { order('created_at DESC') }
end