class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :legacy_title, null: false
      t.string :title, null: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
