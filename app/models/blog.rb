class Blog < ApplicationRecord
    include BlogImagesHandler
    extend FriendlyId
    has_many :blog_images, dependent: :destroy
    has_one_attached :cover_image
    friendly_id :title, use: %i[slugged history]
    belongs_to :category
    belongs_to :subcategory

    def should_generate_new_friendly_id?
        title_changed? || slug.blank?
    end
end
