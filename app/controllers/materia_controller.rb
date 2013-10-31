class MateriaController < ApplicationController
  def cupos
	
  end

 def new
	@materias = Materia.all
 end

def infomateria
	id= params[:id]
	@mate = Materia.find(id)

	#Info planeacion
	@plan1 = Planeacion.where(codigoMateria: id , semestre: "1")
	reg1 = Registro.where(idPlaneacion: @plan1)
	@p1ulti = reg1.where("prioridad like ? ", "%Ultimo%").count
	@p1mismo = reg1.where("prioridad like ? ", "%Mismo%").count

	@plan2 = Planeacion.where(codigoMateria: id , semestre: "2")
	reg2 = Registro.where(idPlaneacion: @plan2)
	@p2ulti = reg2.where("prioridad like ? ", "%Ultimo%").count
	@p2mismo = reg2.where("prioridad like ? ", "%Mismo%").count

	@plan3 = Planeacion.where(codigoMateria: id , semestre: "3")
	reg3 = Registro.where(idPlaneacion: @plan3)
	@p3ulti = reg3.where("prioridad like ? ", "%Ultimo%").count
	@p3mismo = reg3.where("prioridad like ? ", "%Mismo%").count

	@plan4 = Planeacion.where(codigoMateria: id , semestre: "4")
	reg4 = Registro.where(idPlaneacion: @plan4)
	@p4ulti = reg4.where("prioridad like ? ", "%Ultimo%").count
	@p4mismo = reg4.where("prioridad like ? ", "%Mismo%").count

end

def listafiltrada
	@m= params[:M]
	@materias = Materia.all
end

def detalles 
	id= params[:id]
	@sem= params[:sem]
	@materia = Materia.find(id)
	
	plan = Planeacion.where(codigoMateria: id, semestre: @sem)
	@reg = Registro.where(idPlaneacion: plan.first.id)

end 

end 
