class CreateSubcategories < ActiveRecord::Migration[7.0]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.string :slug
      t.index :slug, unique: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_reference :blogs, :subcategory, foreign_key: true, null: false
  end
end
