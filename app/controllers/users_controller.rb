# Checkpoint #41 - Interulude
#
# Since the 'resources :users, only: [:update]' route points to a new action
# (users#update), we'll also have to create a users_controller. Create
# users_controller.rb in the app/controllers directory and add an update method.
class UsersController < ApplicationController
    # Checkpoint #58 - Public Profiles
    #
    # We used a Devise before_action in our controller - run before all public actions - that redirects unauthenticated users (with current_user equal to nil) to the sign-in path. We don't want this to apply to the public profiles, so let's make an exception.
    #
    #before_action :authenticate_user!
    before_action :authenticate_user!, except: [:show]
    
    # Checkpoint #59 - Popular Posts
    #
    # While we're thinking about popular posts, let's build a way to display the top Bloccit users. (See changes to 'routes.rb')
    #
    # Then add the index method in to users_controller.
    def index
        @users = User.top_rated.paginate(page: params[:page], per_page: 10)
    end

    # Checkpoint #58 - Public Profiles
    #
    # The 'show' action is added after altering the user resources statement in the 'routes.rb' file from 'resources :users, only: [:update]' to 'resources :users, only: [:show, :update]'.
    def show
        # Checkpoint #58 - Public Profiles
        #
        # Apparently, in our view (i.e., 'app/views/users/show.html.erb'), we're calling name on a nil object. Look at the view, and you'll see that the offending object is @user. This makes sense, because we forgot to initialize it in the controller. Let's do that, and initialize @posts and @comments while we're at it.
        @user = User.find(params[:id])
        
        # Checkpoint #58 - Public Profiles
        #
        # One important piece of functionality escaped our user flow and testing. Even if a user's profile is public, unauthenticated users should not be able to see the posts of that user which are associated with private topics. To take this into account, we should alter the @posts variable in users#show based on the whether the current user is authenticated.
        #
        # What's the best way to do this? Hint: We did something similar in topics#show.
        #
        # If you guessed that we should use a scope, you were right. Unfortunately, the visible_to scope we wrote for Topic won't be directly usable here. Instead, let's create a visible_to scope on Post that returns all the posts whose topics are visible to the given user.
        #
        # We are using a lambda (->) to ensure that a user is present, or, signed in. If the user is present, we return all posts. If not, we use the Active Record joins method to get all posts for which the topic is public.
        #
        # This query uses a SQL 'inner join' to query a collection's relations at once. Read through the Rails Guide on Active Record to learn more useful querying methods.
        #
        # Don't forget to use this new scope in the UsersController.
        #
        #@posts = @user.posts
        @posts = @user.posts.visible_to(current_user)
        @comments = @user.comments
    end

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