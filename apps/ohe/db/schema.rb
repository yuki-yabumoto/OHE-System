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

ActiveRecord::Schema.define(version: 2021_06_12_101641) do

  create_table "clothes", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "kind"
    t.integer "color"
    t.integer "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
  end

<<<<<<< HEAD
  create_table "coordinates", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "tops"
    t.bigint "bottoms"
    t.bigint "outer"
    t.bigint "shoes"
    t.bigint "accessory"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

=======
>>>>>>> yabumoto/add_tag_data
  create_table "tag_maps", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "clothe_id"
    t.bigint "tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", charset: "utf8mb4", force: :cascade do |t|
    t.string "tag_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", null: false
    t.string "password"
    t.integer "gender"
    t.string "place"
    t.date "from_time"
    t.date "to_time"
    t.integer "favorite_color"
    t.integer "favorite_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
