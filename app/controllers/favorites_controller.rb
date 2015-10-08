# Checkpoint #55 - Favoriting
#
# Notice we didn't specify any views - that is because this controller won't have any normal views. We'll define create and destroy actions, which aren't associated with GET requests, and so have no views. Add the required routes for create and destroy to routes.rb.
class FavoritesController < ApplicationController
   def create
       post = Post.find(params[:post_id])
       favorite = current_user.favorites.build(post: post)
       
       # Checkpoint #55 - Favoriting
       #
       # Let's add authorization to favorites_controller.rb. Add authorize favorite before the if statements in the create and destroy methods.
       authorize favorite
       
       if favorite.save
           flash[:notice] = "Favorite status was saved."
           redirect_to [post.topic, post]
       else
           flash[:error] = "There was an error saving the favorite status. Please try again."
           redirect_to [post.topic, post]
       end
   end
   
   # Checkpoint #55 - Favoriting
   #
   # After adding the unfavoriting functionality to the _favorite partial, we need to add the destroy method to our favorites_controller.
   def destroy
      post = Post.find(params[:post_id]) 
      favorite = current_user.favorites.find(params[:id])
      
      # Checkpoint #55 - Favoriting
      #
      # Let's add authorization to favorites_controller.rb. Add authorize favorite before the if statements in the create and destroy methods.
      authorize favorite
       
      if favorite.destroy
          flash[:notice] = "Favorite status was removed."
          redirect_to [post.topic, post]
      else
          flash[:error] = "There was an error removing the favorite status. Please try again."
          redirect_to [post.topic, post]
      end
   end
end