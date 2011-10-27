Banco::Application.routes.draw do
  namespace :ei do
    resource :session
    resources :courses
  end
end
