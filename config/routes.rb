Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :tickets, only: :create
    end
  end

  resources :tickets, only: %i[index show], controller: 'tickets/tickets'

  root to: 'tickets/tickets#index'
end
