Feature: Planear Materias Segundo Semestre
  Como coordiandor 
  Quiero conocer los cupos necesarios para el tercer semestre de los estudiantes de maestria segun la planeación del semestre pasado
  Para asegurar la culminación sin retraso de cursos.


  Scenario: Asiganar cupos al tercer semestre
    Given I have enter to the planning page
    When I press "Cupos de Tercer Semestre"
    Then I should see a total of 2 quotas

#BD Test
  Scenario: Los cupos son asignados al segundo semestre
    Given I have enter to the planning page
    When I press "Cupos de Segundo Semestre"
    Then The database should have 0 additional rows in the table Registro with semester 3 and idEstudiante 1
    Then The database should have 0 additional rows in the table Registro with semester 3 and idEstudiante 2
    Then The database should have 2 additional rows in the table Registro with semester 3 and idEstudiante 3
#Se asume que el semestre lo nombramos 20151