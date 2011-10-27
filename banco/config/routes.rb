Banco::Application.routes.draw do
  namespace :ei do
    resource :session
    resources :courses do
      resources :students
    end
  end

  namespace :pa do
    resource :session, :controller => "ei/sessions"
    resources :courses do
      resource :schedule
    end
  end

  namespace :ar do
    resource :session, :controller => "ei/sessions"
    resources :students do
      collection do
        get :search
      end
    end    
  end
end
