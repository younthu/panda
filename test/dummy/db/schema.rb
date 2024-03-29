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

ActiveRecord::Schema[7.0].define(version: 2023_04_06_081507) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "panda_admin_roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "admin_role_name_resource_type_and_id_index"
    t.index ["name"], name: "index_panda_admin_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_panda_admin_roles_on_resource"
  end

  create_table "panda_admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_panda_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_panda_admin_users_on_reset_password_token", unique: true
  end

  create_table "panda_admin_users_panda_admin_roles", id: false, force: :cascade do |t|
    t.integer "admin_user_id"
    t.integer "admin_role_id"
    t.index ["admin_role_id"], name: "index_panda_admin_users_panda_admin_roles_on_admin_role_id"
    t.index ["admin_user_id", "admin_role_id"], name: "admin_user_admin_id_role_id_index"
    t.index ["admin_user_id"], name: "index_panda_admin_users_panda_admin_roles_on_admin_user_id"
  end

  create_table "panda_app_versions", force: :cascade do |t|
    t.string "pre_version"
    t.string "current_version"
    t.string "minimal_version"
    t.string "latest_download_url"
    t.integer "app_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_panda_app_versions_on_app_id"
  end

  create_table "panda_apps", force: :cascade do |t|
    t.string "name"
    t.string "platform"
    t.string "official_site"
    t.string "support_email"
    t.string "support_name"
    t.string "support_phone"
    t.string "support_wechat"
    t.date "published_at"
    t.string "owner_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "panda_blacklists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "blocked_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_user_id"], name: "index_panda_blacklists_on_blocked_user_id"
    t.index ["user_id"], name: "index_panda_blacklists_on_user_id"
  end

  create_table "panda_devices", force: :cascade do |t|
    t.integer "user_id"
    t.string "token"
    t.string "name"
    t.string "full_version"
    t.string "os_name"
    t.string "os_full_version"
    t.string "device_name"
    t.string "device_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_panda_devices_on_user_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider"], name: "index_panda_identities_on_provider"
    t.index ["refresh_token"], name: "index_panda_identities_on_refresh_token"
    t.index ["status"], name: "index_panda_identities_on_status"
    t.index ["token"], name: "index_panda_identities_on_token"
    t.index ["uid"], name: "index_panda_identities_on_uid"
    t.index ["user_id"], name: "index_panda_identities_on_user_id"
  end

  create_table "panda_messages", force: :cascade do |t|
    t.string "sender_type", null: false
    t.integer "sender_id", null: false
    t.string "receiver_type", null: false
    t.integer "receiver_id", null: false
    t.string "payload_type"
    t.integer "payload_id"
    t.string "body"
    t.boolean "read", default: false
    t.string "session_id"
    t.string "msg_type", default: "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payload_type", "payload_id"], name: "index_panda_messages_on_payload"
    t.index ["receiver_type", "receiver_id"], name: "index_panda_messages_on_receiver"
    t.index ["sender_type", "sender_id"], name: "index_panda_messages_on_sender"
  end

  create_table "panda_notifications", force: :cascade do |t|
    t.string "sender_type"
    t.integer "sender_id"
    t.integer "receiver_id", null: false
    t.string "payload_type"
    t.integer "payload_id"
    t.string "body"
    t.boolean "read", default: false
    t.string "noti_type", default: "notification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payload_type", "payload_id"], name: "index_panda_notifications_on_payload"
    t.index ["receiver_id"], name: "index_panda_notifications_on_receiver_id"
    t.index ["sender_type", "sender_id"], name: "index_panda_notifications_on_sender"
  end

  create_table "panda_order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_panda_order_items_on_item"
    t.index ["order_id"], name: "index_panda_order_items_on_order_id"
  end

  create_table "panda_orders", force: :cascade do |t|
    t.string "comment"
    t.string "business_type"
    t.string "status"
    t.string "owner_type"
    t.integer "owner_id"
    t.string "title"
    t.string "code"
    t.integer "price_in_cent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_panda_orders_on_owner"
  end

  create_table "panda_payments", force: :cascade do |t|
    t.string "target_type"
    t.integer "target_id"
    t.string "payment_method_type", null: false
    t.integer "payment_method_id", null: false
    t.string "comment"
    t.string "payee_type"
    t.integer "payee_id"
    t.string "payer_type"
    t.integer "payer_id"
    t.integer "amount_in_cent"
    t.integer "fee_in_cent"
    t.integer "actual_pay_in_cent"
    t.string "channel"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payee_type", "payee_id"], name: "index_panda_payments_on_payee"
    t.index ["payer_type", "payer_id"], name: "index_panda_payments_on_payer"
    t.index ["payment_method_type", "payment_method_id"], name: "index_panda_payments_on_payment_method"
    t.index ["target_type", "target_id"], name: "index_panda_payments_on_target"
  end

  create_table "panda_profiles", force: :cascade do |t|
    t.string "store"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_panda_profiles_on_user_id"
  end

  create_table "panda_report_abuses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "target_user_id", null: false
    t.string "content"
    t.string "images"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_user_id"], name: "index_panda_report_abuses_on_target_user_id"
    t.index ["user_id"], name: "index_panda_report_abuses_on_user_id"
  end

  create_table "panda_users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.string "email"
    t.string "name"
    t.string "nick_name"
    t.string "avatar"
    t.string "photos"
    t.date "birthday"
    t.integer "gender"
    t.string "mobile"
    t.text "tokens"
    t.string "secure_token"
    t.datetime "deleted_at", precision: nil
    t.datetime "disabled_at", precision: nil
    t.datetime "disabled_to", precision: nil
    t.datetime "disabled_for", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_panda_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_panda_users_on_deleted_at"
    t.index ["email"], name: "index_panda_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_panda_users_on_reset_password_token", unique: true
    t.index ["secure_token"], name: "index_panda_users_on_secure_token", unique: true
    t.index ["uid", "provider"], name: "index_panda_users_on_uid_and_provider", unique: true
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string "name", null: false
    t.string "environment"
    t.text "certificate"
    t.string "password"
    t.integer "connections", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.string "auth_key"
    t.string "client_id"
    t.string "client_secret"
    t.string "access_token"
    t.datetime "access_token_expiration"
    t.text "apn_key"
    t.string "apn_key_id"
    t.string "team_id"
    t.string "bundle_id"
    t.boolean "feedback_enabled", default: true
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string "device_token", limit: 64
    t.datetime "failed_at", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "app_id"
    t.index ["device_token"], name: "index_rpush_feedback_on_device_token"
  end

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer "badge"
    t.string "device_token", limit: 64
    t.string "sound"
    t.text "alert"
    t.text "data"
    t.integer "expiry", default: 86400
    t.boolean "delivered", default: false, null: false
    t.datetime "delivered_at", precision: nil
    t.boolean "failed", default: false, null: false
    t.datetime "failed_at", precision: nil
    t.integer "error_code"
    t.text "error_description"
    t.datetime "deliver_after", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "alert_is_json", default: false, null: false
    t.string "type", null: false
    t.string "collapse_key"
    t.boolean "delay_while_idle", default: false, null: false
    t.text "registration_ids"
    t.integer "app_id", null: false
    t.integer "retries", default: 0
    t.string "uri"
    t.datetime "fail_after", precision: nil
    t.boolean "processing", default: false, null: false
    t.integer "priority"
    t.text "url_args"
    t.string "category"
    t.boolean "content_available", default: false, null: false
    t.text "notification"
    t.boolean "mutable_content", default: false, null: false
    t.string "external_device_id"
    t.string "thread_id"
    t.boolean "dry_run", default: false, null: false
    t.boolean "sound_is_json", default: false
    t.index ["delivered", "failed", "processing", "deliver_after", "created_at"], name: "index_rpush_notifications_multi", where: "NOT delivered AND NOT failed"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "panda_admin_users_panda_admin_roles", "panda_admin_roles", column: "admin_role_id"
  add_foreign_key "panda_admin_users_panda_admin_roles", "panda_admin_users", column: "admin_user_id"
  add_foreign_key "panda_app_versions", "panda_apps", column: "app_id"
  add_foreign_key "panda_blacklists", "panda_users", column: "blocked_user_id"
  add_foreign_key "panda_blacklists", "panda_users", column: "user_id"
  add_foreign_key "panda_devices", "panda_users", column: "user_id"
  add_foreign_key "panda_identities", "panda_users", column: "user_id"
  add_foreign_key "panda_notifications", "panda_users", column: "receiver_id"
  add_foreign_key "panda_order_items", "panda_orders", column: "order_id"
  add_foreign_key "panda_profiles", "panda_users", column: "user_id"
  add_foreign_key "panda_report_abuses", "panda_users", column: "target_user_id"
  add_foreign_key "panda_report_abuses", "panda_users", column: "user_id"
end
