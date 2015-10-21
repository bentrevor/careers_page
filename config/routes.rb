Rails.application.routes.draw do
  get '/',        to: 'home#home'
  get '/about',   to: 'home#about'
  get '/careers', to: 'home#careers'
end
