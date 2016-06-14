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

ActiveRecord::Schema.define(version: 20160611200418) do

  create_table "calendar", force: :cascade do |t|
    t.date    "c_date"
    t.string  "dayofweek",  limit: 10
    t.string  "holiday",    limit: 50
    t.integer "weeknumber", limit: 4
    t.string  "notes",      limit: 5000
  end

  add_index "calendar", ["c_date"], name: "c_date", using: :btree
  add_index "calendar", ["dayofweek", "holiday", "notes"], name: "dayofweek_holiday_notes", length: {"dayofweek"=>nil, "holiday"=>nil, "notes"=>191}, using: :btree
  add_index "calendar", ["weeknumber"], name: "weeknumber", using: :btree

  create_table "goout", force: :cascade do |t|
    t.integer "menu_id", limit: 4
  end

  add_index "goout", ["menu_id"], name: "FK_goout_restaurant_menu", using: :btree

  create_table "groceryList", primary_key: "groceryListID", force: :cascade do |t|
    t.integer  "userID",       limit: 4
    t.integer  "recipeID",     limit: 4
    t.integer  "active",       limit: 2, default: 1
    t.datetime "dateCreated"
    t.datetime "dateModified"
  end

  add_index "grocerylist", ["active", "dateCreated", "dateModified"], name: "ALL", using: :btree
  add_index "grocerylist", ["recipeID"], name: "fk_recipe_groceryList_idx", using: :btree
  add_index "grocerylist", ["userID"], name: "fk_users_groceryList_idx", using: :btree

  create_table "groceryListItems", primary_key: "groceryListItemID", force: :cascade do |t|
    t.integer  "groceryListID", limit: 4,                                       null: false
    t.integer  "ingredientID",  limit: 4
    t.decimal  "quantity",                 precision: 10, scale: 2
    t.string   "quantityType",  limit: 45
    t.integer  "shopped",       limit: 2,                           default: 0
    t.datetime "dateCreated"
    t.datetime "dateModified"
  end

  add_index "grocerylistitems", ["groceryListID"], name: "fk_groceryList_groceryItems_idx", using: :btree
  add_index "grocerylistitems", ["ingredientID"], name: "fk_groceryListItems_ingredients_idx", using: :btree
  add_index "grocerylistitems", ["shopped", "dateCreated", "dateModified", "quantity", "quantityType"], name: "ALL", using: :btree

  create_table "inventoryCategory", primary_key: "categoryID", force: :cascade do |t|
    t.string   "category",     limit: 45
    t.string   "description",  limit: 1000
    t.datetime "dateCreated"
    t.integer  "insertedBy",   limit: 4,    default: 4
    t.datetime "dateModified"
    t.integer  "updatedBy",    limit: 4,    default: 4
  end

  create_table "kitchenInventory", primary_key: "inventoryID", force: :cascade do |t|
    t.integer  "userID",       limit: 4
    t.integer  "categoryID",   limit: 4
    t.string   "item",         limit: 50
    t.decimal  "quantity",                precision: 10, scale: 2
    t.string   "quantitytype", limit: 50
    t.datetime "dateCreated"
    t.datetime "dateModified"
  end

  add_index "kitcheninventory", ["categoryID"], name: "fk_inventory_category_idx", using: :btree
  add_index "kitcheninventory", ["item", "categoryID", "quantity", "quantitytype"], name: "item_category_quantity_quantitytype", using: :btree
  add_index "kitcheninventory", ["userID"], name: "FK__usersid", using: :btree

  create_table "l_equipment", force: :cascade do |t|
    t.string "name",     limit: 150
    t.string "keywords", limit: 5000, default: "0", null: false
  end

  add_index "l_equipment", ["keywords"], name: "keywords", length: {"keywords"=>191}, using: :btree
  add_index "l_equipment", ["name"], name: "name", unique: true, using: :btree

  create_table "l_ingredients", force: :cascade do |t|
    t.string "name",     limit: 150
    t.string "keywords", limit: 5000
  end

  add_index "l_ingredients", ["keywords"], name: "keywords", length: {"keywords"=>191}, using: :btree
  add_index "l_ingredients", ["name"], name: "name", unique: true, using: :btree

  create_table "mealplan", force: :cascade do |t|
    t.integer "user_id",     limit: 4
    t.integer "calendar_id", limit: 4
    t.integer "recipe_id",   limit: 4
    t.integer "mealtype_id", limit: 4
    t.integer "goout_id",    limit: 4
    t.integer "servings",    limit: 4
    t.string  "notes",       limit: 500
  end

  add_index "mealplan", ["calendar_id"], name: "FK_mealplan_calendar", using: :btree
  add_index "mealplan", ["goout_id"], name: "FK_mealplan_goout", using: :btree
  add_index "mealplan", ["mealtype_id"], name: "FK_mealplan_mealtype", using: :btree
  add_index "mealplan", ["notes"], name: "notes", length: {"notes"=>191}, using: :btree
  add_index "mealplan", ["recipe_id"], name: "FK_mealplan_recipe", using: :btree
  add_index "mealplan", ["servings"], name: "servings", using: :btree
  add_index "mealplan", ["user_id"], name: "FK_mealplan_users", using: :btree

  create_table "mealtype", force: :cascade do |t|
    t.string "mealtype",     limit: 50
    t.time   "servingstart"
    t.time   "servingend"
  end

  add_index "mealtype", ["mealtype"], name: "mealtype", using: :btree
  add_index "mealtype", ["servingstart", "servingend"], name: "servingstart", using: :btree

  create_table "recipeTags", primary_key: "recipeTagID", force: :cascade do |t|
    t.integer  "recipeID",     limit: 4
    t.integer  "tagID",        limit: 4
    t.integer  "insertedBy",   limit: 4,  default: 4
    t.datetime "dateCreated"
    t.string   "updatedBy",    limit: 45, default: "4"
    t.datetime "dateModified"
  end

  add_index "recipetags", ["dateCreated"], name: "SEARCH", using: :btree
  add_index "recipetags", ["recipeID"], name: "fk_recipe_tags_idx", using: :btree
  add_index "recipetags", ["tagID", "recipeID"], name: "comp_recipe_tag", unique: true, using: :btree

  create_table "recipe_equip_used", force: :cascade do |t|
    t.integer "recipie_id",    limit: 4
    t.integer "equipement_id", limit: 4
    t.string  "usage",         limit: 250
  end

  add_index "recipe_equip_used", ["equipement_id"], name: "FK_recipe_equip_used_l_equipment", using: :btree
  add_index "recipe_equip_used", ["recipie_id"], name: "FK_recipe_equip_used_recipe", using: :btree
  add_index "recipe_equip_used", ["usage"], name: "usage", length: {"usage"=>191}, using: :btree

  create_table "recipe_flavors", force: :cascade do |t|
    t.integer "recipe_id", limit: 4
    t.decimal "salty",               precision: 10, scale: 2, default: 0.0
    t.decimal "sour",                precision: 10, scale: 2, default: 0.0
    t.decimal "sweet",               precision: 10, scale: 2, default: 0.0
    t.decimal "bitter",              precision: 10, scale: 2, default: 0.0
    t.decimal "meaty",               precision: 10, scale: 2, default: 0.0
    t.decimal "piquant",             precision: 10, scale: 2, default: 0.0
  end

  add_index "recipe_flavors", ["recipe_id"], name: "FK__recipe", using: :btree
  add_index "recipe_flavors", ["salty", "sour", "sweet", "bitter", "meaty", "piquant"], name: "salty_sour_sweet_bitter_meaty_piquant", using: :btree

  create_table "recipe_images", force: :cascade do |t|
    t.integer  "recipe_id",    limit: 4
    t.string   "image",        limit: 150,             null: false
    t.datetime "dateCreated"
    t.datetime "dateModified"
    t.integer  "insertedBy",   limit: 4,   default: 1
    t.integer  "updatedBy",    limit: 4,   default: 1
  end

  add_index "recipe_images", ["image"], name: "image", using: :btree
  add_index "recipe_images", ["recipe_id"], name: "FK_recipe_images_recipe", using: :btree

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer  "recipe_id",     limit: 4
    t.integer  "ingredient_id", limit: 4
    t.decimal  "quantity",                  precision: 10, scale: 2
    t.string   "measure",       limit: 50
    t.string   "usage",         limit: 500
    t.datetime "dateCreated"
    t.datetime "dateModifed"
    t.integer  "insertedBy",    limit: 4,                            default: 1
    t.integer  "updatedBy",     limit: 4,                            default: 1
  end

  add_index "recipe_ingredients", ["ingredient_id"], name: "FK_recipe_ingredients_l_ingredients", using: :btree
  add_index "recipe_ingredients", ["measure", "usage"], name: "measure_usage", length: {"measure"=>nil, "usage"=>191}, using: :btree
  add_index "recipe_ingredients", ["quantity"], name: "quantity", using: :btree
  add_index "recipe_ingredients", ["recipe_id"], name: "FK_recipe_ingredients_recipe", using: :btree

  create_table "recipe_nutrition", force: :cascade do |t|
    t.integer "recipe_id",     limit: 4
    t.decimal "calorie",                 precision: 10, scale: 2, default: 0.0
    t.decimal "carbohydrates",           precision: 10, scale: 2, default: 0.0
    t.decimal "sugars",                  precision: 10, scale: 2, default: 0.0
    t.decimal "fats",                    precision: 10, scale: 2, default: 0.0
    t.decimal "proteins",                precision: 10, scale: 2, default: 0.0
    t.decimal "sodium",                  precision: 10, scale: 2, default: 0.0
    t.decimal "vitamins",                precision: 10, scale: 2, default: 0.0
  end

  add_index "recipe_nutrition", ["calorie", "carbohydrates", "sugars", "fats", "proteins", "sodium", "vitamins"], name: "calorie_carbohydrates_sugars_fats_proteins_sodium_vitamins", using: :btree
  add_index "recipe_nutrition", ["recipe_id"], name: "FK_recipe_nutrition_recipe", using: :btree

  create_table "recipe_ratereview", id: false, force: :cascade do |t|
    t.integer  "id",             limit: 4,                                           null: false
    t.integer  "recipe_id",      limit: 4
    t.integer  "user_id",        limit: 4
    t.decimal  "rating",                      precision: 10, scale: 2, default: 0.0
    t.integer  "favorite",       limit: 4,                             default: 0
    t.string   "review",         limit: 5000
    t.datetime "dateReviewed"
    t.datetime "dateFavourited"
    t.datetime "dateModified"
  end

  add_index "recipe_ratereview", ["dateModified"], name: "dates", using: :btree
  add_index "recipe_ratereview", ["dateModified"], name: "thedate", using: :btree
  add_index "recipe_ratereview", ["id"], name: "id", using: :btree
  add_index "recipe_ratereview", ["rating", "favorite"], name: "rating", using: :btree
  add_index "recipe_ratereview", ["recipe_id"], name: "FK_recipe_ratereview_recipe", using: :btree
  add_index "recipe_ratereview", ["review"], name: "review", length: {"review"=>191}, using: :btree
  add_index "recipe_ratereview", ["user_id"], name: "FK_recipe_ratereview_users", using: :btree

  create_table "recipe_steps", force: :cascade do |t|
    t.integer "recipe_id", limit: 4
    t.integer "steporder", limit: 4
    t.string  "step",      limit: 500
    t.string  "image",     limit: 500
  end

  add_index "recipe_steps", ["recipe_id"], name: "FK_recipe_steps_recipe", using: :btree
  add_index "recipe_steps", ["step", "image"], name: "step", length: {"step"=>191, "image"=>191}, using: :btree
  add_index "recipe_steps", ["steporder"], name: "steporder", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.string   "course",             limit: 50
    t.string   "name",               limit: 50
    t.string   "cuisine",            limit: 50
    t.decimal  "preptime",                         precision: 10, scale: 2, default: 0.0
    t.string   "authorsTip",         limit: 1000,                                         null: false
    t.integer  "servings",           limit: 4
    t.integer  "servingTypeID",      limit: 4
    t.string   "texture",            limit: 50
    t.string   "tags",               limit: 1000
    t.decimal  "price",                            precision: 10, scale: 2, default: 0.0
    t.text     "story",              limit: 65535
    t.integer  "approval",           limit: 4,                              default: 0
    t.datetime "dateCreated"
    t.integer  "insertedBy",         limit: 4,                              default: 1
    t.datetime "dateModified"
    t.integer  "updatedBy",          limit: 4
    t.string   "cover_file_name",    limit: 255
    t.string   "cover_content_type", limit: 255
    t.integer  "cover_file_size",    limit: 4
    t.datetime "cover_updated_at"
  end

  add_index "recipes", ["dateCreated", "dateModified", "insertedBy", "preptime", "servings"], name: "SEARCH", using: :btree
  add_index "recipes", ["name", "texture", "course", "cuisine", "tags"], name: "name", length: {"name"=>nil, "texture"=>nil, "course"=>nil, "cuisine"=>nil, "tags"=>191}, using: :btree
  add_index "recipes", ["preptime", "servings"], name: "preptime_servings", using: :btree
  add_index "recipes", ["price"], name: "price", using: :btree
  add_index "recipes", ["servingTypeID"], name: "fk_recipe_servingType_idx", using: :btree
  add_index "recipes", ["user_id"], name: "FK_recipe_users", using: :btree

  create_table "rest_menu_ingr", force: :cascade do |t|
    t.integer "rest_menu_id", limit: 4,  default: 0, null: false
    t.string  "name",         limit: 50
  end

  add_index "rest_menu_ingr", ["name"], name: "name", using: :btree
  add_index "rest_menu_ingr", ["rest_menu_id"], name: "FK_rest_menu_ingr_restaurant_menu", using: :btree

  create_table "restaurant", force: :cascade do |t|
    t.string   "rest_type", limit: 50,                             default: "0"
    t.string   "name",      limit: 50
    t.text     "about",     limit: 65535
    t.string   "cover",     limit: 50
    t.string   "address",   limit: 250
    t.float    "lat",       limit: 53
    t.float    "lon",       limit: 53
    t.decimal  "rating",                  precision: 10, scale: 2
    t.time     "openat"
    t.time     "closeat"
    t.string   "manager",   limit: 50
    t.string   "contacts",  limit: 250
    t.datetime "thedate"
  end

  add_index "restaurant", ["cover", "lat", "lon"], name: "cover_lat_long", using: :btree
  add_index "restaurant", ["name", "address", "contacts", "manager"], name: "name_location_manager_contacts", length: {"name"=>nil, "address"=>191, "contacts"=>191, "manager"=>nil}, using: :btree
  add_index "restaurant", ["rating"], name: "rating", using: :btree
  add_index "restaurant", ["rest_type"], name: "rest_type", using: :btree
  add_index "restaurant", ["thedate"], name: "thedate", using: :btree

  create_table "restaurant_images", force: :cascade do |t|
    t.integer "restaurant_id", limit: 4
    t.string  "image",         limit: 50
    t.string  "notes",         limit: 250
    t.string  "thedate",       limit: 45,  default: "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"
  end

  add_index "restaurant_images", ["image", "notes"], name: "image_notes", length: {"image"=>nil, "notes"=>191}, using: :btree
  add_index "restaurant_images", ["restaurant_id"], name: "FK__restaurant", using: :btree
  add_index "restaurant_images", ["thedate"], name: "thedate", using: :btree

  create_table "restaurant_menu", force: :cascade do |t|
    t.integer  "restaurant_id", limit: 4,                             default: 0, null: false
    t.string   "cover",         limit: 50
    t.decimal  "rating",                     precision: 10, scale: 2
    t.string   "name",          limit: 50
    t.string   "description",   limit: 1000,                                      null: false
    t.decimal  "price",                      precision: 10, scale: 2
    t.integer  "servings",      limit: 4
    t.datetime "thedate"
  end

  add_index "restaurant_menu", ["cover"], name: "cover", using: :btree
  add_index "restaurant_menu", ["name"], name: "name_ingredients", using: :btree
  add_index "restaurant_menu", ["price"], name: "price", using: :btree
  add_index "restaurant_menu", ["restaurant_id", "cover"], name: "FK_restaurant_menu_restaurant", using: :btree

  create_table "restaurant_ratereview", force: :cascade do |t|
    t.integer  "restaurant_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.decimal  "rating",                     precision: 10, scale: 2
    t.integer  "favorite",      limit: 4,                             default: 0
    t.string   "review",        limit: 5000
    t.datetime "thedate"
  end

  add_index "restaurant_ratereview", ["rating", "favorite"], name: "rating", using: :btree
  add_index "restaurant_ratereview", ["restaurant_id"], name: "FK_recipe_ratereview_recipe", using: :btree
  add_index "restaurant_ratereview", ["review"], name: "review", length: {"review"=>191}, using: :btree
  add_index "restaurant_ratereview", ["thedate"], name: "thedate", using: :btree
  add_index "restaurant_ratereview", ["user_id"], name: "FK_recipe_ratereview_users", using: :btree

  create_table "serving_types", primary_key: "servingTypeID", force: :cascade do |t|
    t.string   "type",         limit: 45
    t.string   "description",  limit: 500
    t.integer  "insertedBy",   limit: 4,   default: 4
    t.datetime "dateCreated"
    t.integer  "updatedBy",    limit: 4,   default: 4
    t.datetime "dateModified"
  end

  add_index "serving_types", ["type", "dateCreated"], name: "SEARCH", using: :btree

  create_table "sharing", force: :cascade do |t|
    t.integer "user_id",    limit: 4
    t.string  "platform",   limit: 50
    t.string  "share_link", limit: 500
    t.string  "source",     limit: 50
    t.integer "source_id",  limit: 4
  end

  add_index "sharing", ["platform", "share_link", "source"], name: "platform_share_link_source", length: {"platform"=>nil, "share_link"=>191, "source"=>nil}, using: :btree
  add_index "sharing", ["source_id"], name: "source_id", using: :btree
  add_index "sharing", ["user_id"], name: "FK_sharing_users", using: :btree

  create_table "syslogs", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.string   "action",              limit: 50
    t.string   "transaction_type",    limit: 50
    t.string   "transaction_table",   limit: 50
    t.integer  "transaction_tableid", limit: 4
    t.string   "sqlstt",              limit: 3000
    t.datetime "thedate"
  end

  add_index "syslogs", ["action", "transaction_type", "transaction_table", "sqlstt"], name: "action_transaction_type_transaction_table_sqlstt", length: {"action"=>nil, "transaction_type"=>nil, "transaction_table"=>nil, "sqlstt"=>191}, using: :btree
  add_index "syslogs", ["thedate"], name: "thedate", using: :btree
  add_index "syslogs", ["transaction_tableid"], name: "transaction_tableid", using: :btree
  add_index "syslogs", ["user_id"], name: "FK_syslogs_users", using: :btree

  create_table "tags", primary_key: "tagID", force: :cascade do |t|
    t.string   "tag",          limit: 45
    t.integer  "insertedBy",   limit: 4,  default: 4
    t.datetime "dateCreated"
    t.integer  "updatedBy",    limit: 4,  default: 4
    t.datetime "dateModified"
  end

  add_index "tags", ["tag"], name: "tags_tag_uindex", unique: true, using: :btree
  add_index "tags", ["tagID"], name: "tags_tagID_index", using: :btree

  create_table "userPrivateNotes", primary_key: "userPrivateNoteID", force: :cascade do |t|
    t.integer  "userID",       limit: 4,    null: false
    t.integer  "recipeID",     limit: 4,    null: false
    t.string   "privateNote",  limit: 1000
    t.datetime "dateCreated"
    t.datetime "dateModified"
  end

  add_index "userprivatenotes", ["recipeID", "userID"], name: "comp_user_recipe_note", unique: true, using: :btree
  add_index "userprivatenotes", ["recipeID"], name: "fk_recipe_private_note_idx", using: :btree
  add_index "userprivatenotes", ["userID"], name: "fk_user_user_private_note_idx", using: :btree

  create_table "user_logins", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "device_browser", limit: 50
    t.integer  "action",         limit: 4,  default: 1
    t.datetime "thedate"
  end

  add_index "user_logins", ["action"], name: "action", using: :btree
  add_index "user_logins", ["device_browser"], name: "device_browser", using: :btree
  add_index "user_logins", ["thedate"], name: "thedate", using: :btree
  add_index "user_logins", ["user_id"], name: "FK_users_userlogin", using: :btree

  create_table "user_profile", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.decimal  "pikarank",               precision: 10, scale: 2, default: 0.0
    t.decimal  "likesrank",              precision: 10, scale: 2, default: 0.0
    t.decimal  "reviewrank",             precision: 10, scale: 2, default: 0.0
    t.decimal  "socialrank",             precision: 10, scale: 2, default: 0.0
    t.decimal  "mealplanrank",           precision: 10, scale: 2, default: 0.0
    t.datetime "thedate"
  end

  add_index "user_profile", ["pikarank", "likesrank", "reviewrank", "socialrank", "mealplanrank"], name: "pikarank_likesrank_reviewrank_socialrank", using: :btree
  add_index "user_profile", ["user_id"], name: "userid", unique: true, using: :btree

  create_table "user_regdevice", force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.string  "device",  limit: 50
    t.string  "macadd",  limit: 50
    t.string  "ip",      limit: 50
    t.string  "regpath", limit: 50
  end

  add_index "user_regdevice", ["device", "macadd", "ip", "regpath"], name: "device_macadd_ip_regpath", using: :btree
  add_index "user_regdevice", ["user_id"], name: "FK_user_regdevice_users", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "names",                  limit: 50
    t.string   "phone",                  limit: 50
    t.string   "email",                  limit: 50
    t.string   "company",                limit: 50
    t.string   "encrypted_password",     limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_it"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 20
    t.string   "last_sign_in_ip",        limit: 20
    t.string   "cover",                  limit: 50,  default: "default.png"
    t.string   "avatar",                 limit: 50
    t.string   "userBio",                limit: 250
    t.string   "logintype",              limit: 50,  default: "default.png"
    t.datetime "thedate"
    t.string   "role",                   limit: 50,  default: "Author"
    t.integer  "state",                  limit: 4,   default: 0
  end

  add_index "users", ["company"], name: "company", using: :btree
  add_index "users", ["cover"], name: "cover", using: :btree
  add_index "users", ["email"], name: "email", unique: true, using: :btree
  add_index "users", ["logintype"], name: "logintype", using: :btree
  add_index "users", ["names", "phone", "email", "encrypted_password"], name: "names_phone_email_password", using: :btree
  add_index "users", ["thedate"], name: "thedate", using: :btree

  create_table "v_rec_ing_names", id: false, force: :cascade do |t|
    t.integer "id",            limit: 4,                            default: 0, null: false
    t.integer "recipe_id",     limit: 4
    t.integer "ingredient_id", limit: 4
    t.decimal "quantity",                  precision: 10, scale: 2
    t.string  "measure",       limit: 50
    t.string  "usage",         limit: 500
    t.string  "name",          limit: 150
  end

  create_table "v_rest_meal_ing", id: false, force: :cascade do |t|
    t.string  "ing_name",      limit: 50
    t.integer "restaurant_id", limit: 4,  default: 0, null: false
  end

  create_table "v_rest_meals", id: false, force: :cascade do |t|
    t.integer "restaurant_id",   limit: 4,                            default: 0, null: false
    t.string  "rest_cover",      limit: 50
    t.string  "restaurant_name", limit: 50
    t.decimal "rest_rating",                 precision: 10, scale: 2
    t.string  "address",         limit: 250
    t.float   "latitude",        limit: 53
    t.float   "lon",             limit: 53
    t.time    "opening_time"
    t.time    "closing_time"
    t.string  "meal_cover",      limit: 50
  end

  create_table "v_usr_kit_ing", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4,  default: 0, null: false
    t.string  "name",    limit: 50
  end

  add_foreign_key "goout", "restaurant_menu", column: "menu_id", name: "FK_goout_restaurant_menu"
  add_foreign_key "groceryList", "recipes", column: "recipeID", name: "fk_recipe_groceryList", on_delete: :cascade
  add_foreign_key "groceryList", "users", column: "userID", name: "fk_users_groceryList", on_delete: :cascade
  add_foreign_key "groceryListItems", "groceryList", column: "groceryListID", primary_key: "groceryListID", name: "fk_groceryList_groceryItems", on_delete: :cascade
  add_foreign_key "groceryListItems", "l_ingredients", column: "ingredientID", name: "fk_groceryListItems_ingredients"
  add_foreign_key "kitchenInventory", "inventoryCategory", column: "categoryID", primary_key: "categoryID", name: "fk_inventory_category"
  add_foreign_key "kitchenInventory", "users", column: "userID", name: "fk_inventory_user", on_update: :cascade, on_delete: :cascade
  add_foreign_key "mealplan", "calendar", name: "FK_mealplan_calendar"
  add_foreign_key "mealplan", "goout", name: "FK_mealplan_goout"
  add_foreign_key "mealplan", "mealtype", name: "FK_mealplan_mealtype"
  add_foreign_key "mealplan", "recipes", name: "FK_mealplan_recipe"
  add_foreign_key "mealplan", "users", name: "FK_mealplan_users"
  add_foreign_key "recipeTags", "recipes", column: "recipeID", name: "fk_recipe_tags", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipeTags", "tags", column: "tagID", primary_key: "tagID", name: "recipeTags_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipe_equip_used", "l_equipment", column: "equipement_id", name: "FK_recipe_equip_used_l_equipment"
  add_foreign_key "recipe_equip_used", "recipes", column: "recipie_id", name: "FK_recipe_equip_used_recipe"
  add_foreign_key "recipe_flavors", "recipes", name: "FK__recipe"
  add_foreign_key "recipe_images", "recipes", name: "FK_recipe_images_recipe", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipe_ingredients", "l_ingredients", column: "ingredient_id", name: "FK_recipe_ingredients_l_ingredients", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipe_ingredients", "recipes", name: "FK_recipe_ingredients_recipe", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipe_nutrition", "recipes", name: "FK_recipe_nutrition_recipe"
  add_foreign_key "recipe_ratereview", "recipes", name: "FK_recipe_ratereview_recipe", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipe_ratereview", "users", name: "FK_recipe_ratereview_users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipe_steps", "recipes", name: "FK_recipe_steps_recipe", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipes", "servingTypes", column: "servingTypeID", primary_key: "servingTypeID", name: "fk_recipe_servingType", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipes", "users", name: "FK_recipe_users"
  add_foreign_key "rest_menu_ingr", "restaurant_menu", column: "rest_menu_id", name: "FK_rest_menu_ingr_restaurant_menu", on_update: :cascade, on_delete: :cascade
  add_foreign_key "restaurant_images", "restaurant", name: "FK__restaurant"
  add_foreign_key "restaurant_menu", "restaurant", name: "FK_restaurant_menu_restaurant"
  add_foreign_key "restaurant_ratereview", "restaurant", name: "FK_restaurant_ratereview_restaurant"
  add_foreign_key "restaurant_ratereview", "users", name: "restaurant_ratereview_ibfk_2"
  add_foreign_key "sharing", "users", name: "FK_sharing_users"
  add_foreign_key "syslogs", "users", name: "FK_syslogs_users"
  add_foreign_key "userPrivateNotes", "recipes", column: "recipeID", name: "fk_recipe_private_note", on_update: :cascade, on_delete: :cascade
  add_foreign_key "userPrivateNotes", "users", column: "userID", name: "fk_user_user_private_note", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user_logins", "users", name: "FK_users_userlogin", on_delete: :cascade
  add_foreign_key "user_profile", "users", name: "FK__users", on_delete: :cascade
  add_foreign_key "user_regdevice", "users", name: "FK_user_regdevice_users"
end
