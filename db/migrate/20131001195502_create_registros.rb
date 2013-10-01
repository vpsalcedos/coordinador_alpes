class CreateRegistros < ActiveRecord::Migration
  def change
    create_table :registros do |t|
      t.references :idEstudiante, index: true
      t.references :idPlaneacion, index: true
      t.string :prioridad

      t.timestamps
    end
  end
end
