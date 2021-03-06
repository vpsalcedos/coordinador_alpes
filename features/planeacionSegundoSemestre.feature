Feature: Planear Materias Segundo Semestre
  Como coordiandor 
  Quiero conocer los cupos necesarios para el segundo semestre de los estudiantes de maestria segun la planeación del semestre pasado
  Para asegurar la culminación sin retraso de cursos.

 #BehaviourDD Test
  Scenario: Asiganar cupos al segundo semestre
    Given I have enter to the planning page
    When I press "Cupos de Segundo Semestre"
    Then I should see a total of 4 quotas

 #BD Test
  Scenario: Los cupos son asignados al segundo semestre
     Given I have enter to the planning page
     When I press "Planear Semestres"
    Then The database should have 0 additional rows in the table Registro with semester 2 and idEstudiante 1
     Then The database should have 2 additional rows in the table Registro with semester 2 and idEstudiante 2
    Then The database should have 2 additional rows in the table Registro with semester 2 and idEstudiante 3
    #Se asume que el semestre lo nombramos 20142