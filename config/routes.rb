Rails.application.routes.draw do
    # Checkpoint #46 - Comments
    #
    # Nest the comments resource under 'resources :post's in 'routes.rb.'' You
    # only have one comment action for now, create, so only create the routes
    # that you need.
    #
    # Hint: Use only: instead of except.
    #
    # By nesting comments inside of 'posts', they'll be nested inside 'topics'
    # as well. As the 'create' url, '/topics/:topic_id/posts/:post_id/comments',
    # suggests, this "deep nesting" can get complicated, and we should refactor
    # it.
    #
    # Commmented out this next line, since keeping it forms a redundancy with
    # the 'resources :comments, only: [:new, :create]' statement below.
    # get 'comments/:new'

  devise_for :users
  
  # Checkpoint #41 - Interlude
  #
  # To make changing user's name possible, we've added a second form under the
  # "Edit personal information" heading. To make it work we also need to modify
  # the routes and make a dedicated UsersController. Open config/routes.rb file
  # and add the following line below the devise_for :users line.
  resources :users, only: [:update]
  
  # Checkpoint #33 - CRUD
  #
  # "We'll remove those in favor of a more succinct way of creating 'Post'
  # routes. Call the 'resources' method, and pass it a sybmol. By doing this
  # you instruct Rails to create routes for every CRUD action."
  #
  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
  # get 'posts/edit'

  # Mentor feedback:
  #   Delete line 15 (posts are nested under topics now).
  #
  # Question: Why does not the checkpoint explicitly remove or comment out
  # 'resources :posts'?
  #
  # resources :posts
  
  # Checkpoint #40 - Topics and Posts
  #
  # The four statements below were automatically generating by the following
  # command executed in the IRB:
  #
  #     'rails g controller topics index new show edit'
  #
  # get 'topics/index'
  # get 'topics/new'
  # get 'topics/show'
  # get 'topics/edit'
  #
  # However, these are commented out in favor of the shortcut that follows.
  # resources :topics
  # By calling 'resources :posts' in the 'resources :topics' block, you are
  # instructing Rails to create nested routes. Review your new routes by
  # running 'rake routes | grep post'.
  # resources :topics do
    # resources :posts, except: [:index]
    #
    # Checkpoint #46 - Comments
    #
    # Nest the comments resource under 'resources :post's in 'routes.rb.'' You
    # only have one comment action for now, create, so only create the routes
    # that you need.
    #
    # Hint: Use only: instead of except.
    #
    # By nesting comments inside of 'posts', they'll be nested inside 'topics'
    # as well. As the 'create' url, '/topics/:topic_id/posts/:post_id/comments',
    # suggests, this "deep nesting" can get complicated, and we should refactor
    # it.
    # resources :posts, except: [:index] do
      # Checkpoint #51 - Destroy
      #
      # Go back to localhost and try to delete a comment. Did you receive an error? (You should have!) If so, try to troubleshoot it on your own before reading on.
      #
      # The error was raised because you have not created a proper route for destroying comments. Open 'routes.rb' and modify the 'resources :comments' declaration to include 'destroy'.
      #
      # resources :comments, only: [:create]
      #resources :comments, only: [:create, :destroy]
    # end
    
    # Assignment #51 - Destroy
    #
    # As the Rails Guide to Routing makes clear, deep route nesting can "quickly become cumbersome". It is cumbersome in a number of ways:
    #
    # - In 'CommentsController' we separately initialize '@topic', '@post' and '@comment'. We do so because the IDs are in the params hash. However, this is unnecessary because we can find the topic and post from the comment. Furthermore, what would happen if we navigated to '/topics/:topic_id/posts/:id' where the post does not belong to the topic? What would happen if we deleted one of the post's comments?
    #
    # - Our routing is cumbersome. In order to route to a comment, we have to know and reference its parent post and topic.
    #
    # - We nested our routes too deeply. As a result, our path helpers are confusing. Before, we just had post_path, but now we have '[@topic, @post, comment]'', or its unintuitive route, 'topic_post_comment_path'.
    #
    # To solve these issues, implement "shallow nesting".
    #
    # Change your routes file to reflect only the primary relationships.
    #
    # Note the 'only: []'' in the top-level post resources line. This is because we don't want to create any '/posts/:id' routes, just 'posts/:post_id/comments'.
  # end
    resources :topics do
      resources :posts, except: [:index]
    end
    
    resources :posts, only: [] do
      resources :comments, only: [:create, :destroy]
    end
  

  # Checkpoint #33 - CRUD
  #
  # "Notice that we also removed the get 'welcome/index', because we've
  # declared the 'index' view as 'root'. We also cleaned up the 'about'
  # route, by allowing a user to type '/about' rather than /welcome/about'."
  #
  # get 'welcome/index'
  get 'about' => 'welcome#about'
  
  # I commented this out, since it did not appear in this checkpoint.
  # get 'welcome/contact'
  
  root to: 'welcome#index'
end