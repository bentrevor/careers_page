Rails.application.routes.draw do
  get '/',        to: 'home#home', as: 'home'
  get '/about',   to: 'home#about'
  get '/careers', to: 'home#careers'

  resources :positions, only: [:index, :show]
  resources :job_applications, only: [:index, :show]

  get '/apply/:position_id', to: 'job_applications#new', as: 'apply'
  post '/apply', to: 'job_applications#create'
end
