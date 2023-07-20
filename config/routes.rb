Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

# public側ルーティング

  get "search" => "searches#search"

  scope module: :public do

    root to: 'homes#top'

    resources :picture, only: [:index,:show,:edit,:create,:destroy,:update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :public, only: [:index,:show,:edit,:update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end

# admin側ルーティング

  namespace :admin do

    get '' => 'homes#top'

    resources :picture, only: [:index,:show,:edit,:create,:destroy,:update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:destroy]
    end

    resources :genres, only: [:index, :create, :edit, :update]

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
