class ReservasController < ApplicationController
  def ultimosEstudiantes
    @ultimosSem=[]
    creditosFal = Carpeta.select("sum(creditos) as numCred, idEstudiante").where(idMateria:nil).group("idEstudiante");

    creditosFal.each do |est|
      if(est.numCred<=8)
        @ultimosSem.push(Estudiante.find(est.idEstudiante))
      end
    end
    return creditosFal
  end

  def reservasUltimosEst
    ultimosSem=ultimosEstudiantes
    @materias=[]
    ultimosSem.each do |est|
      #Para cada estudiante,definir cada tipo de materia que le falta y el número de cŕeditos
      faltantes=darTiposFaltantes(est.idEstudiante)
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


             end
           end
      end

    end
    @materias=Materia.all

  end


  def darTiposFaltantes(id)
    faltantes=[]
    faltantes=Carpeta.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND idMateria IS NULL",(id)).group("tipoMateria")
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
