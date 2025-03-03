class CreateQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :queries do |t|
      t.string :full_name
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
