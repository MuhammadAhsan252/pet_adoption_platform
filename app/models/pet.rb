class Pet < ApplicationRecord
    extend FriendlyId
    has_many_attached :images
    belongs_to :organization

    friendly_id :name, use: %i[slugged history]

    def should_generate_new_friendly_id?
        name_changed? || slug.blank?
    end
end
