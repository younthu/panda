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

ActiveRecord::Schema.define(version: 2021_06_25_015354) do

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
    t.string "name"
    t.string "nick_name"
    t.string "avatar"
    t.string "gender"
    t.date "birth"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "panda_identities", "users"
  add_foreign_key "panda_profiles", "users"
end
