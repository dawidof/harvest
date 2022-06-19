class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.string :access_token, null: false
      t.string :refresh_token, null: false
      t.string :code, null: false
      t.string :scope, null: false
      t.string :token_type, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
    add_index :tokens, :access_token, unique: true
    add_index :tokens, :refresh_token, unique: true
    add_index :tokens, :code, unique: true
  end
end
