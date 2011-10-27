Integrador::Application.routes.draw do
  resources :sessions
  resource :dashboard
  resources :courses
end
