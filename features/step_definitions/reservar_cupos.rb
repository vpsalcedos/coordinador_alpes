Given(/^I have enter to the home page$/) do
  visit '/reservas/home'
end

When(/^I press "Resrevar"$/) do
  click_button "Ver Cupos semestre 1"
end

Then(/^I should see 32 asigned quotas/) do
  expect(page).to have_content('Total de cupos asignados')
end

When(/^I press "Ver"$/) do
  click_button "Ver"
end

Then(/^I should see 2 asigned quotas/) do
  expect(page).to have_content('de materias que se estos estudiantes tiene que ver es: 2')
end