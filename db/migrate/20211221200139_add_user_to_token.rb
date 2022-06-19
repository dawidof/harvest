class AddUserToToken < ActiveRecord::Migration[7.0]
  def up
    drop_table :users_tokens, if_exists: true
    add_reference :tokens, :user, null: true, foreign_key: true
    remove_index :tokens, :code
    remove_column :tokens, :code, null: false
  end

  def down
    remove_reference :tokens, :user
    add_column :tokens, :code, :string, null: true
    add_index :tokens, :code, unique: true
  end
end
