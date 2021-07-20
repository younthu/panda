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

ActiveRecord::Schema.define(version: 2021_07_20_002630) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "panda_admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_panda_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_panda_admin_users_on_reset_password_token", unique: true
  end

  create_table "panda_identities", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "uid"
    t.string "provider"
    t.string "status"
    t.string "token"
    t.string "refresh_token"
    t.string "scopes"
    t.integer "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider"], name: "index_panda_identities_on_provider"
    t.index ["refresh_token"], name: "index_panda_identities_on_refresh_token"
    t.index ["status"], name: "index_panda_identities_on_status"
    t.index ["token"], name: "index_panda_identities_on_token"
    t.index ["uid"], name: "index_panda_identities_on_uid"
    t.index ["user_id"], name: "index_panda_identities_on_user_id"
  end

  create_table "panda_profiles", force: :cascade do |t|
    t.string "store"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_panda_profiles_on_user_id"
  end

  create_table "panda_users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_panda_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_panda_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_panda_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_panda_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "panda_identities", "users"
  add_foreign_key "panda_profiles", "users"
end
