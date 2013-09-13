Given(/^I have entered (\d+) code in the code field$/) do |h|
  visit '/estado_carpeta/home'
  @code= h.to_i
end

When(/^I press "Ver acumulado carpeta"$/)
  fill_in "codigo", with: @code.to_i
  click_button "Ver acumulado carpeta"
end

Then(/^I should see an error message$/) do
  expect(page).to have_selector('div.alert.alert-error')
end

Given(/^have entered a negative value in the code field$/) do
  visit '/estado_carpeta/home'
  @code=-1
end