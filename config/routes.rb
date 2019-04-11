Rails.application.routes.draw do
  get "/games/:id/obfuscated_target_word", to: "games#obfuscated_target_word"
  resources :games, except: [:edit, :update, :destroy] do
    resources :guesses, except: [:edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
