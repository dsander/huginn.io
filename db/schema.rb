# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161022094754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "agent_gems", force: :cascade do |t|
    t.string   "name"
    t.string   "summary"
    t.string   "description"
    t.string   "repository"
    t.string   "version"
    t.string   "license"
    t.integer  "stars"
    t.integer  "watchers"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "agents", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "creates_events"
    t.boolean  "receives_events"
    t.boolean  "consumes_file_pointer"
    t.boolean  "emits_file_pointer"
    t.boolean  "controls_agents"
    t.boolean  "dry_runs"
    t.boolean  "form_configurable"
    t.string   "oauth_service"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "agent_gem_id"
    t.index "description gin_trgm_ops", name: "agents_description_idx", using: :gin
    t.index "name gin_trgm_ops", name: "agents_name_idx", using: :gin
  end

  create_table "scenarios", force: :cascade do |t|
    t.text     "description"
    t.string   "name"
    t.json     "data"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "guid"
    t.string   "url"
    t.index ["user_id"], name: "index_scenarios_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "provider_uid"
    t.string   "nickname"
    t.string   "name"
    t.string   "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "scenarios", "users"
end
