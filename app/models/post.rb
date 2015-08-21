class Post < ActiveRecord::Base
    has_many :comments
    
    # Checkpoint #38 - Associations
    belongs_to :user
    default_scope { order('created_at DESC') }
    scope :ordered_by_title, -> { order('title ASC') }
    scope :ordered_by_reverse_created_at, -> { order('created_at DESC') }
end