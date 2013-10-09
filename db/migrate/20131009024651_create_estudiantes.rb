class CreateEstudiantes < ActiveRecord::Migration
  def change
    create_table :estudiantes do |t|
      t.string :nombre
      t.string :codigo
      t.string :apellido
      t.string :programa

      t.timestamps
    end
  end
end
