class ReservasController < ApplicationController
  def ultimosEstudiantes
    @ultimosSem=[]
    creditosFal = Carpeta.select("sum(creditos) as numCred, idEstudiante").where(idMateria:nil).group("idEstudiante");

    creditosFal.each do |est|
      if(est.numCred<=8)
        @ultimosSem.push(Estudiante.find(est.idEstudiante))
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
             if(tipofalt.numCreFaltantes<=4)
               #Es solo una materia(Asumiendo materias de 4 créditos)

               randMat=Random.rand(materiasPosibles.size)
               materia=materiasPosibles[randMat]
               materia.cupoUltimoSemestre+=1
               materia.save
             else
               #Tiene varias materias de se tipo

               n= (tipofalt.numCreFaltantes/4).round
               #Asumiendo materias de cuatro créditos

                #Ejecutar el mismo código pero ir eliminando de las posibles materias
                # aquellas a las que ya se adiciono un cupo

               #for i in 0..(n-1)
                 #randMat=Random.rand(materiasPosibles.size)
                 #materia=materiasPosibles[randMat]
                 #materia.cupoUltimoSemestre+=1
                 #materia.save
                 #Como se quita una materia de la lista sin eliminarla de la BD?
               #end
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


  def limpiarEscenario
    materias=Materia.all
    materias.each do |mate|
      mate.cupoUltimoSemestre=0
      mate.save
    end

    render 'home'
  end
end
