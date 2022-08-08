Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'test', to: 'test#index'
  match '/oauth/callback', to: 'test#callback', via: [:get, :post]

end
