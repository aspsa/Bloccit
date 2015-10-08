# Checkpoint #55 - Favoriting
#
# "Favorited" flags need to be associated with the user who flagged the post as a favorite, as well as the post that was flagged as a favorite. This functionality merits a separate model. Create a Favorite model with post and user references - no other attributes are necessary - and migrate the changes.
class Favorite < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
end