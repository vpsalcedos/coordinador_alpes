class PlaneacionController < ApplicationController
  def resultados
    #Numero del semestre para el conflicto
    sem=1
    @conflictos=0
    @estudiantesConflicto=[]
    @materiasConflicto=[]
    #Obtener Estudiantes que les faltan materias
    matFal = Carpeta.select("id, idEstudiante, tipoMateria").where(codigoMateria:nil);
    
    matFal.each do |est|
      idEstudiante =est.idEstudiante
      #Estoy mirando cuantas materias se le agregaron a un estudiante
      total=0
      registros=Registro.where("idEstudiante=?",idEstudiante)
      if(!registros.empty?)
        registros.each do |reg|
          plans=Planeacion.find(reg.idPlaneacion)
          if(plans.semestre==sem)
            total+=1
          end
        end
      end
      #Se termino de comprar las materias inscritas
      #Se mira si por default se le agregaron 2 materias
      if(total <2)
        #Debe ser un conflicto
        if (!estudianteExiste(est.idEstudiante,@estudiantesConflicto))
          @conflictos+=2-total
          @estudiantesConflicto.push(Estudiante.find(est.idEstudiante))
        end
        #Esto no es fijo
        if (!poolExiste(est.idEstudiante,@estudiantesConflicto))
          @materiasConflicto.push(est.tipoMateria)
        end
      end
    end
    
  end
  
  def estudianteExiste(id,estudiantesConflicto)
    bool=false
    estudiantesConflicto.each do |est|
      if(est.id ==id) 
        bool=true
      end
    end
    return bool
  end
  
  def poolExiste(id,estudiantesConflicto)
    bool=false
    estudiantesConflicto.each do |est|
      if(est ==id) 
        bool=true
      end
    end
    return bool
  end
end
