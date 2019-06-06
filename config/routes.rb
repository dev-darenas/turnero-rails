Rails.application.routes.draw do
  resources :consulting_rooms
  resources :turns do
    collection do
      get :show_turns
      get :current_turns
      post :api_create
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "turns#index"
end
