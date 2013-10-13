class ReservasController < ApplicationController

  def ultimosEstudiantes
    @ultimosSem=[]
    creditosFal = Carpeta.select("sum(creditos) as numCred, idEstudiante").where(codigoMateria:nil).group("idEstudiante");
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
    creditosFal = carpetas.select("sum(creditos) as numCred, idEstudiante").where(codigoMateria:nil).group("idEstudiante");

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

      faltantes=Carpeta.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND codigoMateria IS NULL",(id)).group("tipoMateria")
      creditosFal = 0
      faltantes.each do |fal|
        creditosFal += fal.numCreFaltantes
      end

      #creditosFal = (Carpeta.where(idEstudiante: id , codigoMateria: nil , creditos: 4).size)*4
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
    faltantes=carpetas.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND codigoMateria IS NULL",(id)).group("tipoMateria")
    return faltantes
  end

  def agregarAPlaneacion(materia,prioridad,semestre,estudiante)
    planeaciones=Planeacion.all
    planeacionesMateria=planeaciones.where("codigoMateria=? AND semestre=?",(materia),(semestre))
    if(planeacionesMateria.empty?)
      #Toca crearlo
      p=Planeacion.create(codigoMateria: materia, cupos: 1, semestre: semestre)
      p.save
      Registro.create(idEstudiante: estudiante, idPlaneacion: p.id, prioridad: prioridad)
    else
      planeado=planeacionesMateria[0]
      planeado.cupos+=1;
      planeado.save
      Registro.create(idEstudiante: estudiante, idPlaneacion: planeado.id, prioridad: prioridad)
    end

  end

  def darEstUltimosYNoUltSem( semestre)

    ultimosSem=[]
    noUltimoSem=[]
    creditosFal = Carpeta.select("sum(creditos) as numCred, idEstudiante").where(codigoMateria:nil).group("idEstudiante");
    creditosFal.each do |est|
      registros=Registro.where(idEstudiante:est.idEstudiante)
      numRegistroSem=0
      registros.each do |reg|
        plans=Planeacion.find(reg.idPlaneacion)
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
    faltantes=Carpeta.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND codigoMateria IS NULL",(id)).group("tipoMateria")

    registros=Registro.where(idEstudiante:id)
    numRegistroSem=0
    registros.each do |reg|
      plans=Planeacion.find(reg.idPlaneacion)
      if(plans.semestre<semestre)
        mat=Materia.find(plans.codigoMateria)
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

  def semestrePlaneado
    semestre=2
    semestre2Planeado(semestre)
  end

  def semestre2Planeado(semestre)
    #Materias que hacen parte dle semestre planeado
    planes= Planeacion.where("semestre=?", semestre)

    planesMateria=planes.joins('JOIN materia ON materia.id=planeacions.codigoMateria')
    @maestrias=[]
    m=[]
    totalCupos=planes.select("sum(cupos) as cupos").first.cupos
    cuposMaestria=planesMateria.select("sum(cupos) as cupos, programa").group("programa")

    cuposMaestria.each do |cM|
      maest=[]
      maest.push(cM.programa)
      maest.push(cM.cupos)

      maest2=[]
      maest2.push(cM.programa)
      maest2.push((cM.cupos*100)/totalCupos)
      m.push(maest2)

      cuposTipo=planesMateria.select("sum(cupos) as cupos, tipo").where("programa=?",cM.programa).group("tipo")
      tipos=[]
      cuposTipo.each do |cT|
        t=[]
        t.push(cT.tipo)
        t.push(cT.cupos)

        cuposMateria=planesMateria.select("sum(cupos) as cupos, codigoMateria, nombre").where("tipo=?",cT.tipo).group("codigoMateria")
        materias=[]
        cuposMateria.each do |cMat|

          materia=[]
          materia.push(cMat.nombre)
          materia.push(cMat.cupos)

          materias.push(materia)
        end

        t.push(materias)
        tipos.push(t)
      end

      maest.push(tipos)
      @maestrias.push(maest)
    end


   # planes.each do |plan|
    #  mat = Materia.find(plan.codigoMateria)
     # if(!maestrias.key?(mat.programa))
      #  maestrias[mat.programa]=plan.cupos
     # else
      #  maestrias[mat.programa]=maestrias[mat.programa]+plan.cupos
      #end
    #end



    @h = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
      series = {
          :type=> 'pie',
          :name=> 'Cupos por maestria',
          :data=> m
      }
      f.series(series)
      f.options[:title][:text] = "Porcentaje de cupos por maestria"
      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})
      f.plot_options(:pie=>{
          :allowPointSelect=>true,
          :cursor=>"pointer" ,
          :dataLabels=>{
              :enabled=>true,
              :color=>"black",
              :style=>{
                  :font=>"13px Trebuchet MS, Verdana, sans-serif"
              }
          }
      })
    end
  end

end
