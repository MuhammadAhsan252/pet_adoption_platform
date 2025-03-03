class CreateBlogImages < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_images do |t|
      t.belongs_to :blog, foreign_key: true

      t.timestamps
    end
  end
end
