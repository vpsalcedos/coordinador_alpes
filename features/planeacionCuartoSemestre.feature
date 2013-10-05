Feature: Planear Materias Segundo Semestre
  Como coordiandor 
  Quiero conocer los cupos necesarios para el tercer semestre de los estudiantes de maestria segun la planeación del semestre pasado Para asegurar la culminación sin retraso de cursos.


  Scenario: Asiganar cupos al cuarto semestre
    Given I have enter to the planning page
    When I press "Cupos de Cuarto Semestre"
    Then I should see a total of 0 quotas