Feature: Editar Planeacion

  Scenario: No seleciona ninguna materia al editar la planeacion
    Given I am on the planning page
    When I press "Ejecutar planeacion"
    When I press "Si"
    Then I should see "Planeacion Semestre 1"
    Then I should see all the courses
    Then I press "Siguiente" 1
    Then I should see an error message alert
    Then I should see "Planeacion Semestre 1"

  Scenario: Editar materias en todos los semestres
    Given I am on the planning page
    When I press "Ejecutar planeacion"
    When I press "Si"
    Then I should see "Planeacion Semestre 1"
    Then I should see all the courses
    Then I select some courses 1
    Then I press "Siguiente" 1
    Then I should see "Planeacion Semestre 2"
    Then I select some courses 2
    Then I press "Siguiente" 2
    Then I should see "Planeacion Semestre 3"
    Then I select some courses 3
    Then I press "Siguiente" 3
    Then I should see "Planeacion Semestre 4"
    Then I select some courses 4
    Then I press "Terminar"
    Then I should see "Resultados"

  Scenario: Replicar semestres
    Given I am on the planning page
    When I press "Ejecutar planeacion"
    When I press "Si"
    Then I should see "Planeacion Semestre 1"
    Then I should see all the courses
    Then I select some courses 1
    Then I select "3"
    Then I press "Siguiente" 1
    Then I should see "Planeacion Semestre 2"
    Then I select some courses 2
    Then I select "4"
    Then I press "Terminar"
    Then I should see "Resultados"

   #Pruebas sobre BD
  Scenario: Planear sobre las materias correctas
    Given I am on the planning page
    When I presss "Ejecutar planeacion"
    When I press "Si"
    Then I select some courses in each semester
    Then I execute the planning
    Then I should see a valid planning over the courses I selected in each semester