class CreateBlogs < ActiveRecord::Migration[8.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :category
      t.string :slug
      t.index :slug, unique: true
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end
