class Category < ApplicationRecord
    extend FriendlyId
    has_many :blogs, dependent: :destroy
    has_many :subcategories, dependent: :destroy
    friendly_id :name, use: %i[slugged history]

    def should_generate_new_friendly_id?
        name_changed? || slug.blank?
    end
end
