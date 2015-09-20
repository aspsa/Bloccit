# Assignment #44 - Uploading Images
#
# Posts should have images as well as users.
#   - Add an image attribute to Post.
class AddImageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :image, :string
  end
end
