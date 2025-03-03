Rails.application.routes.draw do
  devise_for :admins, :skip => [:registrations]
  as :admin  do
    get 'admins/edit' => 'admins/registrations#edit', :as => 'edit_admin_registration'
    put 'admins' => 'admins/registrations#update', :as => 'admin_registration'
  end

  namespace :admins do
    get '/dashboard', to: 'dashboard#index', as: 'dashboard'

    resources :blogs, only: [:index]

    resources :queries, only: [:index, :destroy]

    resources :categories, except: [:new, :edit] do
      resources :subcategories, except: [:new, :edit, :show]
    end
  end

  resources :blogs do
    post :upload_image, on: :collection
  end

  resources :queries, only: [:create]

  root 'home#index'

  get "/:category/blogs", to: "blogs#blogs_by_category", as: "blogs_by_category"
  get "/:category/:subcategory/blogs", to: "blogs#blogs_by_subcategory", as: "blogs_by_subcategory"

  resources :categories, only: [:show] do
    resources :subcategories, only: [:index]
  end

  get "/pets-for-adoption", to: 'pets_for_adoption#index', as: 'pets_for_adoption'
  get "/pets-for-adoption/:id", to: 'pets_for_adoption#show', as: 'pet_for_adoption'

end
