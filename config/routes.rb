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

  get 'courses' => 'courses#index'
  get 'sites' => 'sites#index'

  post 'course/follow' => 'home#follow_course'
  delete 'course/unfollow' => 'home#unfollow_course'

  get 'timeline' => 'timeline#index'
  get 'timeline/older/:offset' => 'timeline#older_than'
  get 'timeline/since/:since_id' => 'timeline#since'

  get 'calendar' => 'calendar#index'

  get 'schedule/:id' => 'schedule#show'
  get 'schedule/new/:due_date' => 'schedule#new'
  post 'schedule/new/:due_date' => 'schedule#create'

  delete 'schedule/:id/destroy' => 'schedule#destroy'
end
