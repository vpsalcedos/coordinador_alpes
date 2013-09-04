class CreateEstudiantes < ActiveRecord::Migration
  def change
    create_table :estudiantes do |t|
      t.string :nombre
      t.string :apellido
      t.integer :codigo
      t.string :programa

      t.timestamps
    end
  end
end
