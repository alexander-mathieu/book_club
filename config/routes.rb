Rails.application.routes.draw do

  resources :books do
    resources :reviews, except: [:index, :show, :edit, :update]
  end

  resources :authors

  resources :users, only: [:show, :create]

  root to: 'welcome#index'
end
