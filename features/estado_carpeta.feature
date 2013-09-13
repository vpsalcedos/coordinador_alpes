Feature: Ver tipo de materias faltantes y número de materias
  Como estudiante
  quiero conocer una lista de los tipos y número de materias faltantes
  para saber un estado de mi carpeta


  Scenario: Enter a 0 code
    Given I have entered 0 code in the code field
    When I press "Ver acumulado carpeta"
    Then I should see an error message

  Scenario: I have entered a negative value in the code field
    Given I have entered a negative code in the code field
    When I press "Ver acumulado carpeta"
    Then I should see an error messsage