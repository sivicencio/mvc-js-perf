MvcJsPerf::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  resources :users

  resources :apps do
    resources :tests
  end
end