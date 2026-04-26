Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  resource :session
  resources :passwords, param: :token
  resources :requests, only: [:new, :create, :index, :show]
  resources :users, only: [:new, :create, :edit]
  resources :offers, only: [:create, :show, :index]
  
  root "requests#index"
  
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
