Rails.application.routes.draw do
  root to: "games#index"

  resources :games, except: [:edit, :update, :destroy] do
    resources :guesses, except: [:edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
