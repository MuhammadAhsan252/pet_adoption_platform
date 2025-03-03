class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.index :slug, unique: true

      t.timestamps
    end
    add_reference :blogs, :category, foreign_key: true, null: false
  end
end
