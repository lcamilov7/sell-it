Rails.application.routes.draw do
  # PONEMOS PRIMERO LAS RUTAS DE USER Y SESSION PORQUE ESTABA TENIENDO CONFLICTO CON LAS RUTAS DE PRODUCT
  namespace :authentication, path: '', as: '' do # nueva carpeta authentication en controllers donde estará el código de user
    resources :users, only: %i[new create], path: 'register', path_names: { new: '/' }
    resources :sessions, only: %i[new create destroy], path: 'login', path_names: { new: '/'}
  end
  resources :categories, except: :show
  # delete '/products/:id', to: 'products#destroy'
  # patch '/products/:id', to: 'products#update'
  # post '/products', to: 'products#create'
  # get '/products/new', to: 'products#new', as: :new_product
  # get '/products', to: 'products#index'
  # get '/products/:id', to: 'products#show', as: :product
  # get '/products/:id/edit', to: 'products#edit', as: :edit_product
  resources :products, path: '/'
end
