class Registro < ActiveRecord::Base
  belongs_to :idEstudiante
  belongs_to :idPlaneacion
end
