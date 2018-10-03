Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'session#welcome'

  get '/home' => 'users#home'
  get '/transactions' => 'users#transactions'
end
