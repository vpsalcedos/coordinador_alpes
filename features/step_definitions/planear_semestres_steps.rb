Given(/^I have enter to the planning page$/) do
  visit '/reservas/home'
  click_button "Planear Semestres"
end

When(/^I press "Cupos de Segundo Semestre"$/) do
  visit '/reservas/home'
  click_button "Ver Cupos semestre 2"
end

Then(/^I should see a total of 4 quotas/) do
  expect(page).to have_content('Total de cupos asignados = 4')
end

When(/^I press "Cupos de Tercer Semestre"$/) do
  visit '/reservas/home'
  click_button "Ver Cupos semestre 3"
end

Then(/^I should see a total of 2 quotas/) do
  expect(page).to have_content('Total de cupos asignados = 2')
end

When(/^I press "Cupos de Cuarto Semestre"$/) do
  visit '/reservas/home'
  click_button "Ver Cupos semestre 4"
end

Then(/^I should see a total of 0 quotas/) do
  expect(page).to have_content('Total de cupos asignados = ')
end

When(/^I press "Planear Semestres"$/) do
  visit '/reservas/home'
  click_button "Planear Semestres"
end

Then(/^The database should have (\d+) additional rows in the table Registro with semester (\d+) and idEstudiante (\d+)$/) do |arg1,arg2,arg3|

  numEsperado=arg1.to_i
  total=0
  registros=Registro.where("idEstudiante=?",arg3.to_i)
  if(!registros.empty?)
    registros.each do |reg|
      plans=Planeacion.find(reg.idPlaneacion)
      if(plans.semestre==arg2.to_s)
        total+=1
      end
    end
  end
  assert (total==numEsperado)
end
