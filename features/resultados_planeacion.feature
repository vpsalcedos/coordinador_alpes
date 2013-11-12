Feature: Resultados de la planeacion

	Scenario: No existen Conflictos planeacion
		Given I am on the home page and I want to see the planning page
    When I press "Ejecutar planeacion"
    When I press "No"
    Then I should see the tables of the courses
    
  Scenario: Existen Conflictos en el estudiante de Ultimo semestre
		Given I am on the home page and I want to see the planning page
    When I press "Ejecutar planeacion"
    When I press "Si"
    Then I should select courses except MISO-4206 and MISO-4331
    Then I execute the planning
    Then I should see al least 2 conflicts on the result page
    
  Scenario: Ver resultados de planeacio
		Given I am on the result page
    Then I should see the result page title
    Then I should see "# conflictos"
    Then I should see "Estudiantes"
    Then I should see "Consolidado Materias en conflicto"
    
    