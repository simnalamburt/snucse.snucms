Rails.application.routes.draw do
  resources :sites
  devise_for :users, :admins, controllers: { registrations: 'registrations' }
  resources :courses

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: 'authenticated_root'
    end

    unauthenticated do
      root 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end

  post 'course/follow' => 'home#follow_course'
  delete 'course/unfollow' => 'home#unfollow_course'

  get 'timeline' => 'timeline#index'
  get 'timeline/older/:offset' => 'timeline#older_than'
end
