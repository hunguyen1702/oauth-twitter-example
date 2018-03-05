Rails.application.routes.draw do
  root to: "home#index"

  get "home/tweet"
  post "home/tweet"

  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks",
    registrations: "registrations"}
end
