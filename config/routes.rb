Rails.application.routes.draw do
  resources :notes
  #resources :users
  get '/health', to: "health#health"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
