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

ActiveRecord::Schema.define(version: 20131001195502) do

  create_table "carpeta", force: true do |t|
    t.integer  "idEstudiante"
    t.string   "tipoMateria"
    t.integer  "creditos"
    t.integer  "idMateria"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estudiantes", force: true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.integer  "codigo"
    t.string   "programa"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materia", force: true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.string   "tipo"
    t.string   "programa"
    t.integer  "creditos"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "planeacions", force: true do |t|
    t.integer  "idMateria_id"
    t.integer  "cupos"
    t.string   "semestre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "planeacions", ["idMateria_id"], name: "index_planeacions_on_idMateria_id"

  create_table "registros", force: true do |t|
    t.integer  "idEstudiante_id"
    t.integer  "idPlaneacion_id"
    t.string   "prioridad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registros", ["idEstudiante_id"], name: "index_registros_on_idEstudiante_id"
  add_index "registros", ["idPlaneacion_id"], name: "index_registros_on_idPlaneacion_id"

end
