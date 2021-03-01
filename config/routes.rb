Rails.application.routes.draw do

  get 'users/home' => 'users#home'
  get 'users/new' => 'users#new'
  get 'users/login' => 'users#login_form'
  post 'users/login' => 'users#login'
  post 'users/logout' => 'users#logout'
  get 'users/:id' => 'users#show'
  post 'users/create' => 'users#create'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' => 'users#update'
  
  root 'home#top'

  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  get 'posts/:id' => 'posts#show'
  post 'posts/create' => 'posts#create'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' => "posts#update"
  post 'posts/:id/destroy' => "posts#destroy"

  get 'bookmarks/index'  => 'bookmarks#index'
  post 'bookmarks/:post_id/create' => 'bookmarks#create'
  post 'bookmarks/:post_id/destroy' => 'bookmarks#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
