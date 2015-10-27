Rails.application.routes.draw do
  get '/',        to: 'home#home', as: 'home'
  get '/about',   to: 'home#about'

  resources :positions
  get '/careers', to: 'positions#careers'

  resources :job_applications, only: [:index, :show]

  get '/apply/:position_id', to: 'job_applications#new', as: 'new_job_application'
  post '/apply', to: 'job_applications#create', as: 'apply'
end
