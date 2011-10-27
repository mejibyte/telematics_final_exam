Banco::Application.routes.draw do
  namespace :ei do
    resource :session
    resources :courses do
      resources :students
    end
  end
  
  namespace :pa do
    resource :session, :controller => "ei/sessions"
  end
end
