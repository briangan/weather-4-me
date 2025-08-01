Rails.application.routes.draw do
  namespace :weather4_me, path:'/' do
    resources :forecasts, only: [:index, :show]
  end
  
  root to: 'weather4_me/forecasts#index'
end
