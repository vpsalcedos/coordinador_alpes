Feature: Ver estudiantes de ultimo semestre
  Como coordinador
  quiero reservarle un cupo a un estudiante que de último semestre en las materias que le falten y tengan 
  para asegurar los cupos de estos estudiantes.


  Scenario: Asiganar cupos segun BD
    Given I have enter to the home page
    When I press "Ver"
    Then I should see 2 asigned quotas

  Scenario: Asiganar cupos primer semestre
    Given I have enter to the home page
    When I press "Resrevar"
    Then I should see 32 asigned quotas

  #BD Test
  Scenario: Los cupos son asignados al primer semestre en la BD
    Given I have enter to the planning page
    When I press "Planear Semestres"
    Then The database should have 2 additional rows in the table Registro with semester 1 and idEstudiante 1

