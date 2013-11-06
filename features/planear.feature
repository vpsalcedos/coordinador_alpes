Feature: Editar Planeacion

  Scenario: No seleciona ninguna materia al editar la planeacion
    Given I am on the planning page
    When I press "Ejecutar planeacion"
    When I press "Si"
    Then I should see "Planeacion Semestre 1"
    Then I should see all the courses
    Then I press "Siguiente"
    Then I should see an error message
    Then I should see "Planeacion Semestre 1"

  Scenario: Editar materias en todos los semestres
    Given I am on the planning page
    When I press "Ejecutar planeacion"
    When I press "Si"
    Then I should see "Planeacion Semestre 1"
    Then I should see all the courses
    Then I select some courses
    Then I press "Siguiente"
    Then I should see "Planeacion Semestre 2"
    Then I select some courses
    Then I press "Siguiente"
    Then I should see "Planeacion Semestre 3"
    Then I select some courses
    Then I press "Siguiente"
    Then I should see "Planeacion Semestre 4"
    Then I select some courses
    Then I press "Siguiente"
    Then I should see "Resultados"

  Scenario: Replicar semestres
    Given I am on the planning page
    When I press "Ejecutar planeacion"
    When I press "Si"
    Then I should see "Planeacion Semestre 1"
    Then I should see all the courses
    Then I select some courses
    Then I select "3"
    Then I press "Siguiente"
    Then I should see "Planeacion Semestre 2"
    Then I select some courses
    Then I select "4"
    Then I press "Siguiente"
    Then I should see "Resultados"