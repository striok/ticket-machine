Rails.application.routes.draw do

  devise_for :authors
  root :to => "shop/starts#index"

  namespace :authors do
    get '/account' => 'accounts#edit', as: :account

    put '/info' => 'accounts#update_info', as: :info
    put '/change_password' => 'accounts#change_password', as: :change_password
    put '/add_money' => 'accounts#add_money', as: :add_money
    post '/tickets/summary' => 'tickets#buy', as: :summary
    post '/buy' => 'tickets#index', as: :buy
    resources :posts do
      put 'publish' => 'posts#publish', on: :member
      put 'unpublish' => 'posts#unpublish', on: :member
    end
    resources :tickets
    resources :starts
    resources :events
  end

  scope module: 'shop' do
    get 'about' => 'pages#about', as: :about
    get 'contact' => 'pages#contact', as: :contact
    get 'posts' => 'posts#index', as: :posts
    get 'posts/:id' => 'posts#show', as: :post
    get 'starts' => 'starts#index', as: :starts
    get 'events' => 'events#index', as: :events
    get 'events/:id' => 'events#show', as: :event
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
