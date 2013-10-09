class CreatePlaneacions < ActiveRecord::Migration
  def change
    create_table :planeacions do |t|
      t.string :codigoMateria
      t.integer :cupos
      t.string :semestre

      t.timestamps
    end
  end
end
