require 'simplecov'
SimpleCov.start

# Previous content of test helper now starts here

Given(/^I want to see the planning page$/) do

  visit '/welcome/index'
end

When(/^I press "Planeacion"$/) do
  page.find(:link,"Planeacion").click

end

Then(/^I should see "No existe ninguna planeacion en el sistema"$/) do
  expect(page).to have_content('No existe ninguna planeacion en el sistema.')
end

Then(/^I shouldn't see any table$/) do                                                                                                                                                            
  expect(page).to have_no_content('Materia Cupos')
end         

Then(/^I should see the tables of the courses$/) do
  expect(page).to have_content('Materia Cupos')
end

Then(/^the database shouldn't have rows on the tables related$/) do
  boolReg=false
  boolPlan=false
  registros=Registro.all
  if(registros.empty?)
    boolReg=true
  end
  
  if(Planeacion.all.empty?)
    boolPlan=true
  end
  assert(boolReg && boolPlan)
end                                                                                                                                                                                               
                                                                                                                                                                                                  
Given(/^I am on the planning page$/) do
  visit '/reservas/detalles'
end                                                                                                                                                                                               
                                                                                                                                                                                                  
When(/^I press "Ejecutar planeacion"$/) do
  page.find(:link,"Ejecutar planeacion").click
end  
When(/^I press "No"$/) do
  click_button "No"
end  
