class CreatePets < ActiveRecord::Migration[8.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :category
      t.string :size
      t.string :age
      t.string :gender
      t.string :breed
      t.string :color
      t.boolean :spayed_neutered
      t.boolean :house_trained
      t.boolean :declawed
      t.boolean :special_needs
      t.boolean :shots_current
      t.boolean :children
      t.boolean :cats
      t.boolean :dogs
      t.string :tags, array: true, default: []
      t.references :organization, null: false, foreign_key: true
      t.string :slug
      t.index :slug, unique: true

      t.timestamps
    end
  end
end
