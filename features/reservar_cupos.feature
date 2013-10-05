Feature: Ver estudiantes de ultimo semestre
  Como coordinador
  quiero reservarle un cupo a un estudiante que de último semestre en las materias que le falten y tengan 
  para asegurar los cupos de estos estudiantes.


  Scenario: Asiganar cupos segun BD
    Given I have enter to the home page
    When I press "Ver"
    Then I should see 2 asigned quotas