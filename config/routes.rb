Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root :to => "main#index"
  match ':controller(/:action(/:id))', :via => [:post, :get]
  
end
