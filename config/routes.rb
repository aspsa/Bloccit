Rails.application.routes.draw do
  # Checkpoint #33 ("CRUD")
  #
  # Calling the 'resources' method offers a more succinct way of creating
  # Post routes. Rails uses this method to create routes for every CRUD action.
  #
  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
  # get 'posts/edit'
  
  resources :posts

  # Declaring the index view for root precludes the need to invoked the
  # welcome/index HTTP GET.
  # get 'welcome/index'
  #
  # "We also cleaned up the about route, by allowing a user to type /about
  # rather than /welcome/about."
  # get 'welcome/about'
  #
  # I commented this out because this checkpoint excercise does not include it.
  # get 'welcome/contact'

  get 'about' => 'welcome#about'
  
  root to: 'welcome#index'
end