Rails.application.routes.draw do

  devise_for :authors
  root :to => "shop/posts#index"

  namespace :authors do
    resources :posts
    resources :tickets
  end

  scope module: 'shop' do
    get 'about' => 'pages#about', as: :about
    get 'contact' => 'pages#contact', as: :contact
    get 'posts' => 'posts#index', as: :posts
    get 'posts/:id' => 'posts#show', as: :post
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
