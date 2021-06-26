##
## File Name    : routes.rb
## Version      : 1.0
## Designer     : 籔本悠紀
## Purpose      : アプリケーションのルーティングを定義する．
##

Rails.application.routes.draw do
  root "top#index", as: :index
  resource :session, only: [ :new, :create, :destroy ]
  resource :users
  resources :clothes
end
