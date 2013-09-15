Given(/^I have enter to the home page$/) do
  visit '/reservas/home'
end

When(/^I press "Resrevar"$/) do
  click_button "Reservar"
end

Then(/^I should see 32 asigned quotas/) do
  expect(page).to have_content('Número de cupos asignados= ')
end
