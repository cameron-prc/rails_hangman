Rails.application.routes.draw do
  resources :games, except: [:edit, :update, :destroy] do
    resources :guesses, except: [:edit, :update, :destroy]
  end

  post "/random_game" => "games#create_random", as: :create_random_game
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
