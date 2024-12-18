Rails.application.routes.draw do
  root "trans_units#index"

  resources :trans_units, only: [:index] do
    collection do
      post :refresh
    end
  end
end
