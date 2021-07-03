Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'suggest_coordination/suggest'
  get 'suggest_coordination', to: 'suggest_coordination#suggest'
end
