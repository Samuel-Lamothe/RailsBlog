Rails.application.routes.draw do

  get "/" => "users#home"
  get "/home" => "users#home"
  post "/sign_in" => "users#sign_in"
  get "/sign_out" => "users#sign_out"
  post "sign_up" => "users#sign_up"
  resources :user do
    resources :posts 
  end


end
