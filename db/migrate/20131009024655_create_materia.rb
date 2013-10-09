class CreateMateria < ActiveRecord::Migration
  def change
    create_table :materia do |t|
      t.string :nombre
      t.string :codigo
      t.string :tipo
      t.string :programa
      t.integer :creditos

      t.timestamps
    end
  end
end
