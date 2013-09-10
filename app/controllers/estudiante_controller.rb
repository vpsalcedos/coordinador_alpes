class EstudianteController < ApplicationController

  def creditosfaltantes
	@creditosFestu = (Carpeta.where(idEstudiante: = 200822049 , idMateria = nil , creditos: 4))*4
  end
	
  def result 
	@estudiantes = Estudiante.all
  end

end
