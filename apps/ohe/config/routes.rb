##
## File Name    : routes.rb
## Version      : v1.0
## Designer     : 籔本悠紀
## Purpose      : アプリケーションのルーティングを定義する．
##

Rails.application.routes.draw do
  root "top#index", as: :index
  get "login" => "sessions#new", as: :login
  resource :session, only: [ :new, :create, :destroy ]
  resource :users
<<<<<<< HEAD
  resource :clothes
  resource :coordinates

=======
  resources :clothes
>>>>>>> 170d5b63765208198443c0c43e1d1d443225e624
end
