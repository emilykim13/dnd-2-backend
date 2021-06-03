Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: :destroy
      post '/login', to: "auth#login"
      post "/signup", to: "users#create"
      get '/loadlogin', to: "users#show"
    end
  end
end
