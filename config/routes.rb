# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, 
             path: 'api/v1',
             path_names: { 
               sign_in: 'login', 
               sign_out: 'logout', 
               registration: 'signup' 
             },
             controllers: {
               sessions: 'api/v1/sessions',
               registrations: 'api/v1/registrations'
             },
             defaults: { format: :json }

  scope :api, defaults: { format: :json } do
    scope :v1 do
      # 
    end
  end
end
