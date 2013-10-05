Feature: Planear Materias Segundo Semestre
  Como coordiandor 
  Quiero conocer los cupos necesarios para el segundo semestre de los estudiantes de maestria segun la planeación del semestre pasado Para asegurar la culminación sin retraso de cursos.


  Scenario: Asiganar cupos al segundo semestre
    Given I have enter to the planning page
    When I press "Cupos de Segundo Semestre"
    Then I should see a total of 4 quotas