Rails.application.routes.draw do
  get '/',        to: 'home#home', as: 'home'
  get '/about',   to: 'home#about'
  get '/careers', to: 'home#careers'

  get '/apply/:position_id', to: 'job_application#new', as: 'job_applications'
  post '/apply', to: 'job_application#create'
end
