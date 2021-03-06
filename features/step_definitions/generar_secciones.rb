Given(/^I have entered (\d+) number of students in the students per section field$/) do |h|
  visit '/generar_secciones/generar'
  @code= h.to_i
end

When(/^I press "Generar"$/) do
  fill_in "numsecciones", with: @code.to_i
  click_button "Generar"
end

Then(/^I should see an error message of students per section$/) do
  expect(page).to have_selector('div.alert.alert-error')
end

Given(/^I have entered a negative number of students in the students per section field$/) do
  visit '/generar_secciones/generar'
  @code=-1
end

Given(/^I have enter to the visualize page$/) do
  visit '/reservas/home'
end

Given(/^I have enter to the generate section page$/) do
  visit '/generar_secciones/generar'
  @code=1
end
  

When(/^I press "Generar Secciones"$/) do
  click_button "Generar Secciones"
end

Then(/^I should see the generate section page/) do
  expect(page).to have_content('Estudiantes por seccion')
end

Then(/^I should see a table/) do
  expect(page).to have_content('Cupos')
end