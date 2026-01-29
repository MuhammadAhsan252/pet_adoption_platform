class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :postal_code
      t.string :phone
      t.string :email
      t.references :user, foreign_key: true
      t.string :slug
      t.index :slug, unique: true

      t.timestamps
    end
  end
end
