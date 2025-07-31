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

ActiveRecord::Schema.define(version: 2025_07_31_193521) do

  create_table "locations", force: :cascade do |t|
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip_code"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city", "state", "country"], name: "index_locations_on_city_and_state_and_country"
    t.index ["longitude", "latitude"], name: "index_locations_on_longitude_and_latitude"
    t.index ["zip_code", "country"], name: "index_locations_on_zip_code_and_country"
  end

end
