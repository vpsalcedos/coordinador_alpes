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
	
  def buscarEstudiantesMasOcho
	@algunos = []
	todos = Estudiante.all
	todos.each do |estudiante|
		id = estudiante.id
		print("\n------id---------\n")
		print(id)
		print("\n---------------\n")
		creditosFal = (Carpeta.where(idEstudiante: id , idMateria: nil , creditos: 4).size)*4
		if(creditosFal<8)
			e = [ estudiante.id , estudiante.nombre , estudiante.apellido , estudiante.codigo , estudiante.programa , creditosFal ]
			@algunos << e
				print("\n------creditos Faltantes---------\n")
				print(creditosFal)
				print("\n---------------\n")
		else
		end
	end
  end

  def result 
	@estudiantes = Estudiante.all
  end

end
