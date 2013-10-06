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
                 prioridad="Ultimo Semestre " << est.programa
                 agregarAPlaneacion(materia.id,prioridad,"1",est.id)
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
                 prioridad="Ultimo Semestre " << est.programa
                 agregarAPlaneacion(materia.id, prioridad,"1",est.id)

                 materia=materiasPosibles[randMat2]
                 #Agregar el cupo
                 prioridad="Ultimo Semestre " << est.programa
                 agregarAPlaneacion(materia.id,prioridad,"1",est.id)
               end
             end
           end
      end

    end
    @materias=Materia.all
    
  end

  # Inicio métodos para calcular los otros cupos
  #ARREGLARRRRRR!!!!!!!!!!!!!!!!!!!!!!!!!!!
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

  def darPrioridad(materia,estudiante)
    prioridad=""
    if(estudiante.programa==materia.programa)
      prioridad="Mismo programa"
    else
      prioridad=estudiante.programa
    end
    return prioridad
  end

  def darTiposFaltantes(carpetas, id)
    faltantes=[]
    faltantes=carpetas.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND idMateria IS NULL",(id)).group("tipoMateria")
    return faltantes
  end

  def agregarAPlaneacion(materia,prioridad,semestre,estudiante)
    planeaciones=Planeacion.all
    planeacionesMateria=planeaciones.where("idMateria_id=? AND semestre=?",(materia),(semestre))
    if(planeacionesMateria.empty?)
      #Toca crearlo
      p=Planeacion.create(idMateria_id: materia, cupos: 1, semestre: semestre)
      Registro.create(idEstudiante_id: estudiante, idPlaneacion_id: p.id, prioridad: prioridad)
    else
      planeado=planeacionesMateria[0]
      planeado.cupos+=1;
      Registro.create(idEstudiante_id: estudiante, idPlaneacion_id: planeado.id, prioridad: prioridad)
    end

  end

  def darEstUltimosYNoUltSem( semestre)

    ultimosSem=[]
    noUltimoSem=[]
    creditosFal = Carpeta.select("sum(creditos) as numCred, idEstudiante").where(idMateria:nil).group("idEstudiante");
    creditosFal.each do |est|
      registros=Registro.where(idEstudiante_id:est.idEstudiante)
      numRegistroSem=0
      registros.each do |reg|
        plans=Planeacion.find(reg.idPlaneacion_id)
        if(plans.semestre<semestre)
          numRegistroSem+=1
        end
      end

      #Asumiendo materias de 4 créditos
      credFaltantes=est.numCred-numRegistroSem*4;
      if(credFaltantes<=8 and credFaltantes>0)
        ultimosSem.push(Estudiante.find(est.idEstudiante))
        puts "Ultimo semestre"
        puts est.idEstudiante
      elsif (credFaltantes>8)
        noUltimoSem.push(Estudiante.find(est.idEstudiante))
        puts "No Ultimo semestre"
        puts est.idEstudiante
      end
    end
    return ultimosSem, noUltimoSem
  end

  def darTiposFaltantesSem( id, semestre)
    faltantes=[]
    faltantes=Carpeta.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND idMateria IS NULL",(id)).group("tipoMateria")

    registros=Registro.where(idEstudiante_id:id)
    numRegistroSem=0
    registros.each do |reg|
      plans=Planeacion.find(reg.idPlaneacion_id)
      if(plans.semestre<semestre)
        mat=Materia.find(plans.idMateria_id)
        faltantes.detect{|f|
          if(f.tipoMateria == mat.tipo)
            f.numCreFaltantes= f.numCreFaltantes-4
          end
        }
      end
    end

    return faltantes
  end


  def limpiarEscenario
    Planeacion.delete_all
    Registro.delete_all
    render 'home'
  end

def reservasSemestrePorEstUltimo(semestre)
    
    ultimosSem,noUltimoSem=darEstUltimosYNoUltSem(semestre)
    @materias=[]
    ultimosSem.each do |est|

      #Para cada estudiante,definir cada tipo de materia que le falta y el número de cŕeditos
      faltantes=darTiposFaltantesSem( est.id, semestre)
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
                 prioridad="Ultimo Semestre " << est.programa
                 agregarAPlaneacion(materia.id,prioridad,semestre,est.id)
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
                 prioridad="Ultimo Semestre " << est.programa
                 agregarAPlaneacion(materia.id, prioridad,semestre,est.id)

                 materia=materiasPosibles[randMat2]
                 #Agregar el cupo
                 prioridad="Ultimo Semestre " << est.programa
                 agregarAPlaneacion(materia.id,prioridad,semestre,est.id)
               end
             end
           end
      end

    end
    @materias=Materia.all
    
  end

  # Inicio métodos para calcular los otros cupos
  #ARREGLARRRRRR!!!!!!!!!!!!!!!!!!!!!!!!!!!
  def reservasSemestrePorEst(semestre)

    
    ultimosSem,noUltimoSem=darEstUltimosYNoUltSem(semestre)
    @materias=[]
    noUltimoSem.each do |est|

      #Para cada estudiante,definir cada tipo de materia que le falta y el número de cŕeditos
      faltantes=darTiposFaltantesSem( est.id, semestre)

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
              prioridad=darPrioridad(materia,est)
              agregarAPlaneacion(materia.id,prioridad,semestre,est.id)


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
              prioridad=darPrioridad(materia,est)
              agregarAPlaneacion(materia.id,prioridad,semestre,est.id)
              i += 1
            end
            if(i<2)
              materia=materiasPosibles[randMat2]
              #materia.cupo+=1
              #materia.save
              prioridad=darPrioridad(materia,est)
              agregarAPlaneacion(materia.id,prioridad,semestre,est.id)
              i += 1
            end
          end
        end
      end
      
    end
    @materias =  Materia.all
  end

  def planearSemestres
    Planeacion.delete_all
    Registro.delete_all

    #Planeacion de primer semestre
    reservasUltimosEst
    cuposmas8
    #Planeacion otros semestres
    semestre=2
    while semestre<5 do
      reservasSemestrePorEstUltimo(semestre.to_s)
      reservasSemestrePorEst(semestre.to_s)
      semestre+=1
    end
    registros=Registro.all
    puts registros.length

    render 'home'
  end

end
