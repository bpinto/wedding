Rails.application.routes.draw do

  # You can have the root of your site routed with "root"
  root 'home#index'

  get :rsvp, to: 'guests#new', as: :rsvp

  resources :guests, only: [:create, :index]
end
