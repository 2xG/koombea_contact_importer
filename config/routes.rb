Rails.application.routes.draw do
  devise_for :users

  resources :contacts, only: :index do
    get 'errors', on: :collection
  end
  resources :contact_lists, except: %i[new show destroy]
  root to: 'contacts#index'
end
