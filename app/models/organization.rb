class Organization < ApplicationRecord
    extend FriendlyId
    has_one_attached :logo
    belongs_to :user, optional: true
    has_many :pets, dependent: :destroy

    friendly_id :name, use: %i[slugged history]

    def should_generate_new_friendly_id?
        name_changed? || slug.blank?
    end
end
