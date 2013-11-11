class PlaneacionController < ApplicationController
  def resultados
    @conflictos=0
    @estudiantesConflicto=[]
    @materiasConflicto=[]
    creditosFal = Carpeta.select("sum(creditos) as numCred, idEstudiante").where(codigoMateria:nil).group("idEstudiante");
    @totalCred=0
    creditosFal.each do |est|
      if(est.numCred<=8)
        @ultimosSem.push(Estudiante.find(est.idEstudiante))
        @totalCred+=est.numCred
      end
    end
    
  end
end
