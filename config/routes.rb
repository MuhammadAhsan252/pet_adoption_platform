Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  authenticated :admin do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  root to: "pages#index"
  resources :blogs, only: %i[index show]

  get "/pets-for-adoption", to: "pets_for_adoption#index", as: "pets_for_adoption"
  get "/pets-for-adoption/:id", to: "pets_for_adoption#show", as: "pet_for_adoption"

  resources :sitemap, only: %i[index], constraints: ->(req) { req.format == :xml }
end
