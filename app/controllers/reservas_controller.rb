class ReservasController < ApplicationController
  def ultimosEstudiantes
    @ultimosSem=[]
    creditosFal = Carpeta.select("sum(creditos) as numCred, idEstudiante").where(idMateria:nil).group("idEstudiante");
    @totalCred=0
    creditosFal.each do |est|
      if(est.numCred<=8)
        @ultimosSem.push(Estudiante.find(est.idEstudiante))
        @totalCred+=est.numCred
      end
    end

  end

  def darEstUltimosSem(carpetas)
    ultimosSem=[]
    creditosFal = carpetas.select("sum(creditos) as numCred, idEstudiante").where(idMateria:nil).group("idEstudiante");

    creditosFal.each do |est|
      if(est.numCred<=8)
        ultimosSem.push(Estudiante.find(est.idEstudiante))
      end
    end
    return ultimosSem
  end

  def reservasUltimosEst
    carpetas=Carpeta.all
    ultimosSem=darEstUltimosSem(carpetas)
    @materias=[]
    ultimosSem.each do |est|

      #Para cada estudiante,definir cada tipo de materia que le falta y el número de cŕeditos
      faltantes=darTiposFaltantes(carpetas, est.id)
      if(!faltantes.empty?)
          #Para cada tipo que le falta, buscar la lista de materias faltantes de ese tipo
           faltantes.each do |tipofalt|
             materiasPosibles= Materia.where("tipo=?", tipofalt.tipoMateria)
             if(!materiasPosibles.empty?)
               if(tipofalt.numCreFaltantes<=4)
                 #Es solo una materia(Asumiendo materias de 4 créditos)

                 randMat=Random.rand(materiasPosibles.size)
                 materia=materiasPosibles[randMat]
                 #Agregar el cupo
                 agregarAPlaneacion(materia.id,"Ultimo Semestre","1",est.id)
               else
                 #Le faltan dos materias

                 n= (tipofalt.numCreFaltantes/4).round

                 randMat1=Random.rand(materiasPosibles.size)
                 randMat2=Random.rand(materiasPosibles.size)
                 while(randMat1==randMat2)
                   randMat2=Random.rand(materiasPosibles.size)
                 end
                 materia=materiasPosibles[randMat1]
                 #Agregar el cupo
                 agregarAPlaneacion(materia.id,"Ultimo Semestre","1",est.id)

                 materia=materiasPosibles[randMat2]
                 #Agregar el cupo
                 agregarAPlaneacion(materia.id,"Ultimo Semestre","1",est.id)
               end
             end
           end
      end

    end
    @materias=Materia.all

  end


  def darTiposFaltantes(carpetas, id)
    faltantes=[]
    faltantes=carpetas.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND idMateria IS NULL",(id)).group("tipoMateria")
    return faltantes
  end

  def agregarAPlaneacion(materia,prioridad,semestre,estudiante)
    planeaciones=Planeacion.all
    planeacionesMateria=planeaciones.where("idMateria_id=? AND semestre=1",(materia))
    if(planeacionesMateria.empty?)
      #Toca crearlo
      p=Planeacion.create(idMateria_id: materia, cupos: 1, semestre: semestre)
      Registro.create(idEstudiante_id: estudiante, idPlaneacion_id: p.id, prioridad: prioridad)
    else
      planeado=planeacionesMateria[1]
      
      Registro.create(idEstudiante_id: estudiante, idPlaneacion_id: 1, prioridad: prioridad)
    end
    
  end


  def limpiarEscenario
    materias=Materia.all
    materias.each do |mate|
      mate.cupoUltimoSemestre=0
      mate.cupo=0  #
      mate.save
    end

    render 'home'
  end
end
