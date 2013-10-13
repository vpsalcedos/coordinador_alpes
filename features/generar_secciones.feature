Feature: Generar Secciones
Como coordinador 
quiero que el sistema me genere secciones con un número de estudiantes fijo 
para conocer la cantidad de secciones a crear para el nuevo semestre

  Scenario: Generate sections view
    Given I have enter to the visualize page
    When I press "Generar Secciones"
    Then I should see the generate section page

  Scenario: Enter a 0 students per sections
    Given I have entered 0 number of students in the students per section field
    When I press "Generar"
    Then I should see an error message of students per section

  Scenario: I have entered a negative value in the students per sections field
    Given I have entered a negative number of students in the students per section field
    When I press "Generar"
    Then I should see an error message of students per section

  Scenario: Succesful generate sections
    Given I have enter to the generate section page
    When I press "Generar"
    Then I should see a table