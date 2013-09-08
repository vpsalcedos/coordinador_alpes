class CreateCarpeta < ActiveRecord::Migration
  def change
    create_table :carpeta do |t|
      t.integer :idEstudiante
      t.string :tipoMateria
      t.integer :creditos
      t.integer :idMateria

      t.timestamps
    end
  end
end
