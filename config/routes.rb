Rails.application.routes.draw do
  root to: 'welcome#index'

  post '/books', to: 'books#create'
  get '/books', to: 'books#index'
  get '/books/new', to: 'books#new', as: :new_book
  get '/books/:id', to: 'books#show', as: :book
  get '/books/:id/edit', to: 'books#edit', as: :edit_book
  patch '/books/:id', to: 'books#update'
  delete '/books/:id', to: 'books#destroy'

  post '/books/:book_id/reviews', to: 'reviews#create', as: :book_reviews
  get '/books/:book_id/reviews/new', to: 'reviews#new', as: :new_book_review
  delete '/books/:book_id/reviews/:id', to: 'reviews#destroy', as: :book_review

  post '/authors', to: 'authors#create'
  get '/authors', to: 'authors#index'
  get '/authors/new', to: 'authors#new', as: :new_author
  get '/authors/:id', to: 'authors#show', as: :author
  get '/authors/:id/edit', to: 'authors#edit', as: :edit_author
  patch '/authors/:id', to: 'authors#update'
  delete '/authors/:id', to: 'authors#destroy'

  put '/users', to: 'users#create'
  get '/users/:id', to: 'users#show', as: :user
end
