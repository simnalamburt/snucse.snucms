Rails.application.routes.draw do
  devise_for :users, :admins, controllers: { registrations: 'registrations' }
  resources :courses

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: 'authenticated_root'
    end

    unauthenticated do
      root 'devise/sessions#new', as: 'unauthenticated_root'
      get 'signup', to: 'registrations#new'
    end
  end

  get 'course/list' => 'home#course_list'
  post 'course/follow' => 'home#follow_course'
  delete 'course/unfollow' => 'home#unfollow_course'
end
