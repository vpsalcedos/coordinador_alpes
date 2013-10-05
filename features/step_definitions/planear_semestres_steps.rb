Given(/^I have enter to the planning page$/) do
  visit '/reservas/home'
end

When(/^I press "Cupos de Segundo Semestre"$/) do
  click_button "Cupos de Segundo Semestre"
end

Then(/^I should see a total of 4 quotas/) do
  expect(page).to have_content('Total de cupos asignados = 4')
end

When(/^I press "Cupos de Tercer Semestre"$/) do
  click_button "Cupos de Tercer Semestre"
end

Then(/^I should see a total of 2 quotas/) do
  expect(page).to have_content('Total de cupos asignados = 2')
end

When(/^I press "Cupos de Cuarto Semestre"$/) do
  click_button "Cupos de Cuarto Semestre"
end

Then(/^I should see a total of 0 quotas/) do
  expect(page).to have_content('Total de cupos asignados = 0')
end