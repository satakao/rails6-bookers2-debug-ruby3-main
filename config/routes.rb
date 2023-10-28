Rails.application.routes.draw do
  get 'relasionships/create'
  get 'relasionships/destroy'
  get 'book_comments/create'
  get 'book_comments/destroy'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to:"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    resource :favorite,only: [:create, :destroy]
    resources :book_comments,only: [:create, :destroy]
  end
  resources :users, only: [:new, :index,:show,:edit,:update]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
