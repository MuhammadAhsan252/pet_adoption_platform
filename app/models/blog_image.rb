class BlogImage < ApplicationRecord
  has_one_attached :image
  belongs_to :blog, optional: true
end
