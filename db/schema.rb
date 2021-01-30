# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 6) do

  create_table "breeds", force: :cascade do |t|
    t.string "name"
  end

  create_table "doctor_dogs", force: :cascade do |t|
    t.string   "date"
    t.string   "time"
    t.integer  "dog_id"
    t.integer  "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctor_shelters", force: :cascade do |t|
    t.integer "shelter_id"
    t.integer "doctor_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

  create_table "dogs", force: :cascade do |t|
    t.string  "name"
    t.string  "desc"
    t.integer "age"
    t.integer "breed_id"
    t.integer "shelter_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "website"
  end

end
