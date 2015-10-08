# Checkpoint #55 - Favoriting
#
# Adding an email_favorites attribute to the users table will provide a way for users to control whether or not they receive emails from Bloccit.
class AddEmailPermissionToUsers < ActiveRecord::Migration
  def change
    # Checkpoint #55 - Favoriting
    #
    # Open the migration and set the email_favorites attribute to true by default.
    #add_column :users, :email_favorites, :boolean
    add_column :users, :email_favorites, :boolean, default: true
  end
end