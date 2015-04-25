Rails.application.routes.draw do
  devise_for :users, :admins, controllers: { registrations: 'registration' }
  resources :courses

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: 'authenticated_root'
    end

    unauthenticated do
      root 'devise/sessions#new', as: 'unauthenticated_root'
      get 'signup', to: 'registration#new'
    end
  end

  get 'course/list' => 'home#course_list'
end
