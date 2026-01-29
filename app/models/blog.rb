class Blog < ApplicationRecord
    extend FriendlyId

    has_rich_text :content
    has_one_attached :cover_image
    has_many_attached :trix_attachments
    validates :title, presence: true

    friendly_id :title, use: %i[slugged history]

    def should_generate_new_friendly_id?
        title_changed? || slug.blank?
    end
end
