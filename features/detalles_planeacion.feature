Feature: Ver planeacion

	Scenario: No existe planeacion
		Given I want to see the planning page
		When I press "Planeacion"
		Then I should see "No existe ninguna planeacion en el sistema"
    Then I shouldn't see any table
    Then the database shouldn't have rows on the tables related
    
  Scenario: Ver detalles de una planeacion
    Given I am on the planning page
    When I press "Ejecutar planeacion"
    When I press "No"
    Then I should see the tables of the courses