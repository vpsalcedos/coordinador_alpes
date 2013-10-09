class CreateRegistros < ActiveRecord::Migration
  def change
    create_table :registros do |t|
      t.integer :idEstudiante
      t.integer :idPlaneacion
      t.string :prioridad

      t.timestamps
    end
  end
end
