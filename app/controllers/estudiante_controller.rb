class EstudianteController < ApplicationController

  def creditosfaltantes
	@codigo= params[:codigo]
	print("\n------codigo---------\n")
	print(@codigo)
	print("\n---------------\n")

	e = Estudiante.find_by codigo:@codigo
	
	c = Carpeta.where(idEstudiante: e.id , idMateria: nil , creditos: "4")
	@creditosFestu = c.size*4

	print("\n------creditos---------\n")
	print(@creditosFestu)
	print("\n---------------\n")
  end
	
  def result 
	@estudiantes = Estudiante.all
  end

end
