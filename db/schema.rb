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

ActiveRecord::Schema.define(version: 20180331055057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "campaigns", force: :cascade do |t|
    t.json "pictures"
    t.string "title"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id"
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
  end

  create_table "customer_connects", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "friend_id", null: false
    t.string "subject"
    t.text "msg", null: false
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "friend_id"], name: "CUSTOMER_CONNECT"
    t.index ["state"], name: "CONNECT_STATE"
  end

  create_table "customers", force: :cascade do |t|
    t.string "username", null: false
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "country", null: false
    t.string "customer_type", null: false
    t.string "status"
    t.integer "user_id", null: false
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city", "state", "status", "username", "latitude", "longitude"], name: "CTS-INDEX"
  end

  create_table "discussions", force: :cascade do |t|
    t.integer "customer_connect_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_connect_id"], name: "index_discussions_on_customer_connect_id"
  end

  create_table "employee_posts", force: :cascade do |t|
    t.string "job_category", null: false
    t.string "employee_category", null: false
    t.string "job_duration", null: false
    t.string "pay_type", null: false
    t.string "employee_type", null: false
    t.string "employee_title", null: false
    t.string "employee_experience", null: false
    t.integer "customer_id", null: false
    t.text "description", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_category"], name: "EMPLOYEE_CATEGORY"
    t.index ["employee_experience"], name: "EXPERIENCE_EMPLOYEE"
    t.index ["employee_title"], name: "EMPYEE_TTLE"
    t.index ["employee_type"], name: "EMPLOYEE_TYPE"
    t.index ["job_duration", "pay_type"], name: "EMPLOYEE_PAY"
  end

  create_table "employer_posts", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "status"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insights", force: :cascade do |t|
    t.date "available_date", null: false
    t.string "job_category", null: false
    t.string "employee_category", null: false
    t.string "job_duration", null: false
    t.string "pay_type", null: false
    t.string "employee_type", null: false
    t.string "employee_title", null: false
    t.integer "employer_post_id", null: false
    t.string "employee_experience", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_post_id"], name: "EMPLOYER_POST"
    t.index ["job_category", "employee_category", "employee_title", "employee_type", "pay_type"], name: "JOB_EMPLOYEE_TITLE_TYPE_PAY"
  end

  create_table "job_locations", force: :cascade do |t|
    t.string "location", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.integer "employer_post_id", null: false
    t.string "status"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city", "state", "employer_post_id", "latitude", "longitude"], name: "CITY_STATE_EMPLOYER"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "conversation_id"
    t.bigint "customer_id"
    t.text "msg", null: false
    t.string "sender_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["customer_id"], name: "index_messages_on_customer_id"
    t.index ["sender_name"], name: "index_messages_on_sender_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "customers"
end
