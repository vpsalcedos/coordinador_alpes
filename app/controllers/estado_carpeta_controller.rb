class EstadoCarpetaController < ApplicationController
  def estadoCarpeta
    #Falta agregar un parametro
    codigo="200819111"
    #El estudiante con el código requerido
    estudiantes=Estudiante.where("codigo=200822524")
    @estudiante=estudiantes[0];
    id=estudiante.id
    #Las entradas correspondientes a las materias que le faltan al estudiante.
    materias=Carpeta.select("tipoMateria, sum(creditos) as numFaltantes").where("idEstudiante=? AND idMateria=null",(id)).group("tipoMateria")
  end
end
