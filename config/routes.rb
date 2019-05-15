Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cats 

  resources :cat_rental_requests, only: [:new, :create, :edit, :update, :destroy] do
    member do
      post :approve, to: 'cat_rental_requests#approve', as: 'approve'
      post :deny, to: 'cat_rental_requests#deny', as: 'deny'
    end
  end
end
