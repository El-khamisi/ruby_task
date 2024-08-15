Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

    # Defines the root path route ("/")
    # root "posts#index"

    resources :applications, param: :token, only: [ :create, :show, :update ] do
      resources :chats, only: [ :create, :index, :show ], param: :number do
        resources :messages, only: [ :index, :create ] do
          collection do
            get "search"
          end
        end
      end
    end
end
