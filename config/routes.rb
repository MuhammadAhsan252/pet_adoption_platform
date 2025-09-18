Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  authenticated :admin do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  root to: "pages#index"
  resources :blogs, only: %i[index show]

  get "/pets-for-adoption", to: 'pets_for_adoption#index', as: 'pets_for_adoption'
  get "/pets-for-adoption/:id", to: 'pets_for_adoption#show', as: 'pet_for_adoption'

  get '/dog-name-generator', to: 'dog_name_generator#index', as: 'dog_name_generator'
  get '/cat-name-generator', to: 'cat_name_generator#index', as: 'cat_name_generator'
  get '/horse-name-generator', to: 'horse_name_generator#index', as: 'horse_name_generator'

  post "gemini/generate", to: "gemini#generate"
  post "dog_name_generator/build_prompt", to: "dog_name_generator#build_prompt"
  post "cat_name_generator/build_prompt", to: "cat_name_generator#build_prompt"
  post "horse_name_generator/build_prompt", to: "horse_name_generator#build_prompt"
  resources :sitemap, only: %i[index], constraints: ->(req) { req.format == :xml }

end
