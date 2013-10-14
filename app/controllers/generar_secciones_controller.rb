class GenerarSeccionesController < ApplicationController
  def generar
  	
  end
  def generarSecciones
  	numestu=params[:numsecciones].to_i
  	semestre = 1
    if(numestu<=0)
    	flash[:error] = 'Numero de estudiantes invalido'
    	render 'generar'
    else
    	
     	planes= Planeacion.where("semestre=?", semestre)
    	planesMateria=planes.joins('JOIN materia ON materia.id=planeacions.codigoMateria')
    	seccionM=planesMateria.select("sum(cupos) as cupos, codigoMateria, nombre").group("codigoMateria")
    	sec=[]
    	seccionM.each do |cMat|
    		cantidadS= cMat.cupos/numestu.to_f
    		if(cantidadS.round==0)
    			cantidadS=1
    		end
    		ocup= cantidadS.round*numestu
    		
    		ocupacion = (cMat.cupos/ocup.to_f)*100
    		materia=[]
         	materia.push(cMat.codigoMateria)
          	materia.push(cMat.nombre)
          	materia.push(cMat.cupos)
          	materia.push(cantidadS.round)
          	materia.push(ocupacion.round(1))

          	sec.push(materia)
    		
    	end
    	@secciones=sec
    	@n=numestu
    	@prueba= "width: 20%"
  	end
  end
end
