class EstudianteController < ApplicationController
  def result
	@estudiantes = Estudiante.all

  end
end
