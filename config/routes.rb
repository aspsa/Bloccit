Rails.application.routes.draw do
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

  resources :posts

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