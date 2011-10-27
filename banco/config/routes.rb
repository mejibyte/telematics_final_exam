Banco::Application.routes.draw do
  namespace :ei do
    resource :session
    resources :courses do
      resources :students
    end
  end
end
