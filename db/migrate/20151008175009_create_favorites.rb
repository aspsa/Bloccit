# Checkpoint #55 - Favoriting
#
# "Favorited" flags need to be associated with the user who flagged the post as a favorite, as well as the post that was flagged as a favorite. This functionality merits a separate model. Create a Favorite model with post and user references - no other attributes are necessary - and migrate the changes.
#
# Because the favorites table doesn't have any special data of its own - just its associations - it can be considered a simple join table. A join table represents a relationship between two objects - in this case, a user and a post.
class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end