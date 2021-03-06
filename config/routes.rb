Rails.application.routes.draw do
  namespace :chirpper do
    namespace :v1 do
      resources :chirps, only: [:index, :create], via: :options do
        member do
          post :upvote, via: :options
        end
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
