class CreateMateria < ActiveRecord::Migration
  def change
    create_table :materia do |t|
      t.string :nombre
      t.string :codigo
      t.integer :cupoUltimoSemestre
      t.integer :cupo
      t.string :tipo

      t.timestamps
    end
  end
end
