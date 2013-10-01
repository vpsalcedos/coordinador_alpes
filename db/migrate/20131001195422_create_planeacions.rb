class CreatePlaneacions < ActiveRecord::Migration
  def change
    create_table :planeacions do |t|
      t.references :idMateria, index: true
      t.integer :cupos
      t.string :semestre

      t.timestamps
    end
  end
end
