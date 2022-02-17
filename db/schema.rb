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

ActiveRecord::Schema.define(version: 2) do

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.string "version"
    t.string "r_version_needed"
    t.string "dependencies"
    t.string "date_of_publication"
    t.string "title"
    t.string "authors"
    t.string "maintainers"
    t.string "license"
    t.string "url"
    t.index ["authors"], name: "index_packages_on_authors"
    t.index ["maintainers"], name: "index_packages_on_maintainers"
    t.index ["name"], name: "index_packages_on_name"
  end

end
