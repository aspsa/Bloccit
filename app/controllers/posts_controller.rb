# Checkpoint #59 - Popular Posts
#
# Now that we've nested the rest of our post views under topics, let's create the top-level Posts controller and routes.
#
# Notice that we are using the visible_to scope to handle public / private posts based on the current_user object.
#
# Also take note of the "created_at > ?", 7.days.ago syntax. This both lets us use the simple Ruby date syntax and is a countermeasure against SQL Injection.
class PostsController < ApplicationController
    def index
        @posts = Post.visible_to(current_user).where("posts.created_at > ?", 7.days.ago).paginate(page: params[:page], per_page: 10)
    end
end