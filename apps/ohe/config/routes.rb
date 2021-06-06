##
## File Name    : routes.rb
## Version      : 1.0
## Designer     : 籔本悠紀
## Purpose      : アプリケーションのルーティングを定義する．
##

Rails.application.routes.draw do
  root "top#index", as: :index
  get "login" => "sessions#new", as: :login
  resource :session, only: [ :create, :destroy ]
  resource :users
  resource :clothes
end
