Rails.application.routes.draw do
  root 'static_pages#home'
  get 'home/:id' => "static_pages#home"
  get 'bill/bill'
  get 'bill/delete/:id' => 'bill#delete'
  get 'bill_items/delete/:id' => 'bill_items#delete'
  get 'bill_items/order/:id' => 'bill_items#order'
  
  get 'bill/add/:id' => 'bill#add_bill'
  # resources :bill_items
  get 'bill_items/:id' => "bill_items#show"
  resources :foods
  resources :categories
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resolve("ActiveStorage::Variant") { |variant, options| main_app.route_for(:rails_variant, variant, options) }
end
