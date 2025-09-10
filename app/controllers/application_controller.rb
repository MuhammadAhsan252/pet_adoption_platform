class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :initialize_metas

    def initialize_metas
      set_meta_tags title: "Your Farm Partner",
                    description: "Petcurehub is a all in one platform for pet lovers",
                    keywords: "pets, pet adoption, pet care, pet services, pet products, pet health, pet training, pet grooming",
                    og: {
                      title: "Your Farm Partner",
                      description: "Petcurehub is a all in one platform for pet lovers",
                      url: "https://www.petcurehub.com",
                      image: helpers.image_path("logo.png")
                    }
    end
end
