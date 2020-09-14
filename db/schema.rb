# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_11_194615) do

  create_table "adoptions", force: :cascade do |t|
    t.integer "owner_id"
    t.integer "shelter_id"
    t.integer "dog_id"
    t.boolean "owner_conf", default: false
    t.boolean "shelter_conf"
    t.boolean "adopted", default: false
    t.index ["dog_id"], name: "index_adoptions_on_dog_id"
    t.index ["owner_id"], name: "index_adoptions_on_owner_id"
    t.index ["shelter_id"], name: "index_adoptions_on_shelter_id"
  end

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.string "breed"
    t.string "age"
    t.string "gender"
    t.string "description"
    t.string "home_state"
    t.integer "owner_id"
    t.integer "shelter_id"
    t.index ["owner_id"], name: "index_dogs_on_owner_id"
    t.index ["shelter_id"], name: "index_dogs_on_shelter_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "home_state"
    t.string "about_me"
    t.string "password_digest"
    t.string "uid"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "home_state"
    t.string "about_us"
    t.string "password_digest"
  end

end
