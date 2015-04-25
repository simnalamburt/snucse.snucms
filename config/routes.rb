Rails.application.routes.draw do
  devise_for :users, :admins
  resources :courses

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: 'authenticated_root'
    end

    unauthenticated do
      root 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end

  get 'course/list' => 'home#course_list'
end
