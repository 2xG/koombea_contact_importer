Rails.application.routes.draw do
  devise_for :users

  resources :contacts, only: :index
  root to: 'contacts#index'
end
