Features: Informacion estudiante
Como coordinador 
Quiero conocer la informacion academica del estudiante
Para realizar una planeacion mas optima acorde a sus necesidades

Scenario: Informacion estudiante correcta
Given a user visit the estudiante page
when she click on any estudiante from the estudiante page list
Then she should see materias faltantes information
And she should see planeacion information



