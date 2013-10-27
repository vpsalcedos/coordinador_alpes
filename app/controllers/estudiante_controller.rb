class EstudianteController < ApplicationController
  
def creditosfaltantes
	@codigo= params[:codigo]
	print("\n------codigo---------\n")
	print(@codigo)
	print("\n---------------\n")

	e = Estudiante.find_by codigo:@codigo

	c = Carpeta.where(idEstudiante: e.id , codigoMateria: nil)
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

		faltantes=Carpeta.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND codigoMateria IS NULL",(id)).group("tipoMateria")
		creditosFal = 0
		faltantes.each do |fal|
			creditosFal += fal.numCreFaltantes		
		end
		
		#creditosFal = (Carpeta.where(idEstudiante: id , idMateria: nil , creditos: 4).size)*4
		if(creditosFal>8)
			e = [ estudiante.id , estudiante.nombre , estudiante.apellido , estudiante.codigo , estudiante.programa , creditosFal ]
			@algunos << e
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

      faltantes=Carpeta.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND codigoMateria IS NULL",(id)).group("tipoMateria")
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
          if(!materiasPosibles.empty?)
            if(tipofalt.numCreFaltantes<=4)
              #Es solo una materia(Asumiendo materias de 4 créditos)
              if(i<2)
                          randMat=Random.rand(materiasPosibles.length)
                          materia=materiasPosibles[randMat]

                          #materia.cupo+=1
                          #materia.save
                          prioridad=darPrioridad(materia,estudiante)
                          agregarAPlaneacion(materia.id,prioridad,"1",id)


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
                          #materia.cupo+=1
                          #materia.save
                          prioridad=darPrioridad(materia,estudiante)
                          agregarAPlaneacion(materia.id,prioridad,"1",id)
                i += 1
              end
              if(i<2)
                materia=materiasPosibles[randMat2]
                        #materia.cupo+=1
                        #materia.save
                        prioridad=darPrioridad(materia,estudiante)
                        agregarAPlaneacion(materia.id,prioridad,"1",id)
                i += 1
              end
            end
          end
        end
      end
    end
    @materias =  Materia.all

  end

  def agregarAPlaneacion(materia,prioridad,semestre,estudiante)
    planeaciones=Planeacion.all
    planeacionesMateria=planeaciones.where("codigoMateria_id=? AND semestre=1",(materia))
    if(planeacionesMateria.empty?)
      #Toca crearlo
      p=Planeacion.create(idMateria_id: materia, cupos: 1, semestre: semestre)
      Registro.create(idEstudiante_id: estudiante, idPlaneacion_id: p.id, prioridad: prioridad)
    else
      planeado=planeacionesMateria[1]

      Registro.create(idEstudiante_id: estudiante, idPlaneacion_id: 1, prioridad: prioridad)
    end

  end

  def darPrioridad(materia,estudiante)
    prioridad=""
    if(estudiante.programa==materia.programa)
      prioridad="Mismo programa"
    else
      prioridad=estudiante.programa
    end
    return prioridad
  end



def listafiltrada
	@m= params[:M]
	@estudiantes = Estudiante.all
	
  end


def infoestudiante
	id= params[:id]
	@e = Estudiante.find(id)

	#Creditos faltantes
	c = Carpeta.where(idEstudiante: id , codigoMateria: nil)
	@creditosFestu = c.size*4
	#Semestre actual
	act=40-@creditosFestu
	tmp=act/8
	if(tmp<1) 
		tmp ="no ha visto materias"
	end
	if(tmp==4)
		tmp= "Último semestre"
	end
	@semact=tmp
	
	#las materais que le ahcen falta
        @faltantes=Carpeta.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND codigoMateria IS NULL",(@e.id)).group("tipoMateria")
       
    	#tabla planeacion
@s1m1=""
@s1m2=""
@s2m1=""
@s2m2=""
@s3m1=""
@s3m2=""
@s4m1=""
@s4m2=""

	reg = Registro.where(idEstudiante: @e.id )
	reg.each do |re|
		plan = Planeacion.find(re.idPlaneacion)
		seme = plan.semestre
		ma = Materia.find(plan.codigoMateria)
		if(seme == "1")
			if(@s1m1=="")
				@s1m1=ma.codigo
			else
				@s1m2=ma.codigo
			end
		end
		if(seme =="2")
			if(@s2m1=="")
				@s2m1=ma.codigo
			else
				@s2m2=ma.codigo
			end
		end
		if(seme =="3")
			if(@s3m1=="")
				@s3m1=ma.codigo
			else
				@s3m2=ma.codigo
			end
		end
		if(seme =="4")
			if(@s4m1=="")
				@s4m1=ma.codigo
			else
				@s4m2=ma.codigo
			end
		end
	end      
end



end
