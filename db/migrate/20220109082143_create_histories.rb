class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.datetime :from_date, null: false
      t.datetime :to_date, null: false
      t.jsonb :data, null: false, default: {}
      t.decimal :total, precision: 6, scale: 2, default: 0, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
