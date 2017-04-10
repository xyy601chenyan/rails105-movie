
Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root "movies#index"

 resources :movies do
   member do
     post :join
     post :quit
     post :collect
     post :cancel
   end

   resources :reviews
 end

 namespace :account do
   resources :movies
     resources :reviews
     resources :collections
   end






end
