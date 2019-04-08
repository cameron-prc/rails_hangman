Rails.application.routes.draw do
  resources :games, except: [:edit, :update, :destroy] do
    resources :guesses
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
