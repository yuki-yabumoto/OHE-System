##
## File Name    : routes.rb
## Version      : v1.1
## Designer     : 籔本悠紀
## Date         : 2021.07.05
## Purpose      : アプリケーションのルーティングを定義する．
##

Rails.application.routes.draw do
  root "top#index", as: :index
  get "login" => "sessions#new", as: :login
  resource :session, only: [ :new, :create, :destroy ]
  resource :users
  resources :clothes
  resources :coordinates

  match '*', to: 'application#rescue404', via: :all

end
