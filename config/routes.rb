Rails.application.routes.draw do
  get "up" => "health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post "auth/sign_in", to: "auth#sign_in"
      post "auth/sign_up", to: "auth#sign_up"
      get "auth/me", to: "auth#me"
      resources :users, only: %i[index show update], constraints: { id: /[0-9]+/ }
      resources :partners, only: %i[index]
      namespace :admin do
        get "dashboard", to: "dashboard#index"
        resources :partners
      end
    end
  end
end
