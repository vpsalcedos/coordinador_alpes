Features: Informacion materia
Como coordinador 
Quiero conocer la información planeada de cada materia
Para realizar una asignación adecuada de los recursos

Scenario: Informacion materia correcta
Given a user visit the materia page
when she click on any materia from the materia page list
Then she should see materia information
And she should see detalles link
