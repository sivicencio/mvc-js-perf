MvcJsPerf::Application.routes.draw do 
  root :to => "home#index"
  devise_for :users
  resources :users

  resources :apps do
    resources :tests
    resources :instances
  end

  get '/tests/:test_id/instances/:instance_id/runs', to: 'runs#index', as: 'test_instance_runs'
  post '/tests/:test_id/instances/:instance_id/runs', to: 'runs#run_test', as: 'run_test'
  delete '/tests/:test_id/instances/:instance_id/runs', to: 'runs#clear_runs', as: 'clear_runs'

  resources :frameworks
end