class EstadoCarpetaController < ApplicationController
  def estadoCarpeta
    #Falta agregar un parametro
    codigo=params[:codigo].to_i
    if(codigo<=0)
      flash.now[:error] = 'Codigo invalido!!'
      render 'home'

    else
      #El estudiante con el código requerido
      estudiantes=Estudiante.where("codigo=?", codigo)
      if(estudiantes.length>0)
        @estudiante=estudiantes[0];

        id=@estudiante.id
        #Las entradas correspondientes a las materias que le faltan al estudiante.
        @faltantes=Carpeta.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND idMateria IS NULL",(id)).group("tipoMateria")
        #http://guides.rubyonrails.org/active_record_querying.html
      else
        flash.now[:error] = 'Codigo invalido!!'
        render 'home'
      end
    end
  end
  def home

  end
end
