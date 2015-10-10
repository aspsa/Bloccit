# Checkpoint #41 - Interulude
#
# Since the 'resources :users, only: [:update]' route points to a new action
# (users#update), we'll also have to create a users_controller. Create
# users_controller.rb in the app/controllers directory and add an update method.
class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def update
        if current_user.update_attributes(user_params)
            flash[:notice] = "User information updated"
            redirect_to edit_user_registration_path
        else
            flash[:error] = "Invalid user information"
            redirect_to edit_user_registration_path
        end
    end
    
    private
    
    def user_params
        # Checkpoint #44 - Uploading Images
        #
        # We've added a new "avatar" attribute to the user model. Now we need
        # to allow this attribute to be updated in the users_controller. Open
        # 'app/controllers/users_controller.rb' and change the definition of
        # the user_params method to as follows.
        #
        # Because we've "extracted" user_params to its own method rather than
        # repeating the require and permit calls in multiple places, this edit
        # only needs to be made in one place. Also note that we only need to
        # permit the attributes we want to update here. We can leave password
        # and other permissions to Devise.
        #
        # params.require(:user).permit(:name)
        #
        # Checkpoint #57 - Another Interlude
        #
        # To allow the email_favorites attribute to be saved (see changes in 'app/views/devise/registrations/edit.html.erb'), our users_controller needs a small change as well. Open app/controllers/users_controller.rb and change the definition of the user_params method to permit :email_favorites.
        #
        #params.require(:user).permit(:name, :avatar)
        params.require(:user).permit(:name, :avatar, :email_favorites)
    end
end