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

		faltantes=Carpeta.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND idMateria IS NULL",(id)).group("tipoMateria")
		creditosFal = 0
		faltantes.each do |fal|
			creditosFal += fal.numCreFaltantes		
		end
		
		#creditosFal = (Carpeta.where(idEstudiante: id , idMateria: nil , creditos: 4).size)*4
		if(creditosFal>8)
			e = [ estudiante.id , estudiante.nombre , estudiante.apellido , estudiante.codigo , estudiante.programa , creditosFal ]
			@algunos << e

		else
		end
	end
end

  def result
	@estudiantes = Estudiante.all
  end

  def cuposmas8
	
	@algunos = []
	todos = Estudiante.all
	todos.each do |estudiante|
		id = estudiante.id

		faltantes=Carpeta.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND idMateria IS NULL",(id)).group("tipoMateria")
		creditosFal = 0
		faltantes.each do |fal|
			creditosFal += fal.numCreFaltantes		
		end
		
		#creditosFal = (Carpeta.where(idEstudiante: id , idMateria: nil , creditos: 4).size)*4
		if(creditosFal>8)
			#e = [ estudiante.id , estudiante.nombre , estudiante.apellido , estudiante.codigo , estudiante.programa , creditosFal ]
			#@algunos << e
			i = 0
			faltantes.each do |tipofalt|
				 materiasPosibles= Materia.where("tipo=?", tipofalt.tipoMateria)
				
				if(tipofalt.numCreFaltantes<=4)
              			 	#Es solo una materia(Asumiendo materias de 4 créditos)
					if(i<2)
               					randMat=Random.rand(materiasPosibles.size)
               					materia=materiasPosibles[randMat]
               					materia.cupo+=1
               					materia.save
					
						i += 1 
					end
            			 else
              				#Le faltan dos materias

					n= (tipofalt.numCreFaltantes/4).round
               			 	randMat1=Random.rand(materiasPosibles.size)
              				randMat2=Random.rand(materiasPosibles.size)
              			 	while(randMat1==randMat2)
               			 	 	randMat2=Random.rand(materiasPosibles.size)
             			 	end
					if(i<2)
             					materia=materiasPosibles[randMat1]
            					materia.cupo+=1
            			 		materia.save
						i += 1
					end
					if(i<2)
						materia=materiasPosibles[randMat2]
           			 		materia.cupo+=1
            			 		materia.save	
						i += 1
					end
				end
			
				
			end
		else
		end
	end
	@materias =  Materia.all

  end
end
