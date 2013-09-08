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

ActiveRecord::Schema.define(version: 20130908155458) do

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
    t.integer  "cupoUltimoSemestre"
    t.integer  "cupo"
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
