Rails.application.routes.draw do
  get 'messages/create'
  get 'searches/search'
  # get 'relasionships/create'
  # get 'relasionships/destroy'
  # get 'book_comments/create'
  # get 'book_comments/destroy'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to:"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    resource :favorite,only: [:create, :destroy]
    resources :book_comments,only: [:create, :destroy]
  end
  #ユーザーにフォロー機能をネストさせてこのユーザーをフォローするといったアクションでユーザー指定できるようにする
  resources :users, only: [:new, :index,:show,:edit,:update]do
    resources :relationships,only: [:create, :destroy,]
  end
  resources :users do
    #member doを使うことで特定のユーザーidを紐づけてそのユーザーのfollowings,followersをget,一覧で表示できるように
    member do
     get :followings, :followers
    end
  end
  resources :searches, only: [:search]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :index, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
