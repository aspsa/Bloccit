Rails.application.routes.draw do
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
  resources :topics do
    resources :posts, except: [:index]
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