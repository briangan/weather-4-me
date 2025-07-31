Rails.application.routes.draw do
  namespace :weather4_me do
    resources :forecasts
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
