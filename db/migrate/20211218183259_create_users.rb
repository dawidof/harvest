class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :avatar_url
      t.jsonb :received_data, default: {}
      t.jsonb :task_categories, default: {}

      t.timestamps
    end

    add_index :users, :provider
    add_index :users, :uid
    add_index :users, :email, unique: true
    add_index :users, %i[provider uid], unique: true
  end
end
