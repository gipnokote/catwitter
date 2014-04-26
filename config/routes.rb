Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get    'sign_in',  to: 'devise/sessions#new'
    get    'sign_up',  to: 'devise/registrations#new'
    get    'profile',  to: 'devise/registrations#edit'
    delete 'sign_out', to: 'devise/sessions#destroy'
  end
  
  resources :posts
  resources :users do
    member do
      post 'follow'
      post 'unfollow'
      post 'block'
      post 'unblock'
    end
  end
  
  resources :comments
  
  root to: 'posts#index', as: :home
end
