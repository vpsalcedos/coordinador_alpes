class MateriaController < ApplicationController
  def cupos
	@materias = Materia.all
  end
end
