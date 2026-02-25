# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, 
             path: 'api/v1',
             path_names: { 
               sign_in: 'login', 
               sign_out: 'logout', 
               registration: 'signup',
               password: 'forgot_password'

             },
             controllers: {
               sessions: 'api/v1/sessions',
               registrations: 'api/v1/registrations',
               passwords: 'api/v1/passwords'
             },
             defaults: { format: :json }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/jobs', to: 'jobs#index'
    end
  end
end
