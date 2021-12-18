class CreateUsersTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :users_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.references :token, null: false, foreign_key: true

      t.timestamps
    end

    add_index :users_tokens, [:user_id, :token_id], unique: true
  end
end
