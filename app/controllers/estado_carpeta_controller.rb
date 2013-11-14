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
        @faltantes=Carpeta.select("tipoMateria, sum(creditos) as numCreFaltantes").where("idEstudiante=? AND codigoMateria IS NULL",(id)).group("tipoMateria")
        #http://guides.rubyonrails.org/active_record_querying.html
      else
        flash.now[:error] = 'Codigo invalido!!'
        render 'home'
      end
    end
  end
  def home

  end
  
  def carpeta
  id= '309'
  @e = Estudiante.find(id)

  #Creditos faltantes
  c = Carpeta.where(idEstudiante: id , codigoMateria: nil)
  @creditosFestu = c.size*4
  #Semestre actual
  #act=40-@creditosFestu
  #tmp=act/8
  #if(tmp<1) 
  tmp=""
  if(@creditosFestu>39)
    tmp ="no ha visto materias"
  end
  #if(tmp==4)
  if(@creditosFestu<9)
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
        @s1m1=ma
      else
        @s1m2=ma
      end
    end
    if(seme =="2")
      if(@s2m1=="")
        @s2m1=ma
      else
        @s2m2=ma
      end
    end
    if(seme =="3")
      if(@s3m1=="")
        @s3m1=ma
      else
        @s3m2=ma
      end
    end
    if(seme =="4")
      if(@s4m1=="")
        @s4m1=ma
      else
        @s4m2=ma
      end
    end
  end      
end

end
