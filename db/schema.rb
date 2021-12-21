# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_21_154401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tokens", force: :cascade do |t|
    t.string "access_token", null: false
    t.string "refresh_token", null: false
    t.string "code", null: false
    t.string "scope", null: false
    t.string "token_type", null: false
    t.datetime "expires_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["access_token"], name: "index_tokens_on_access_token", unique: true
    t.index ["code"], name: "index_tokens_on_code", unique: true
    t.index ["refresh_token"], name: "index_tokens_on_refresh_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "avatar_url"
    t.jsonb "received_data", default: {}
    t.jsonb "task_categories", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "settings", default: {}, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["uid"], name: "index_users_on_uid"
  end

  create_table "users_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "token_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token_id"], name: "index_users_tokens_on_token_id"
    t.index ["user_id", "token_id"], name: "index_users_tokens_on_user_id_and_token_id", unique: true
    t.index ["user_id"], name: "index_users_tokens_on_user_id"
  end

  add_foreign_key "users_tokens", "tokens"
  add_foreign_key "users_tokens", "users"
end
