Given(/^I am on the home page and I want to see the planning page$/) do
  visit '/welcome/index'
  page.find(:link,"Planeacion").click
end

Given(/^I am on the result page$/) do
  visit '/planeacion/resultados'
end

Then(/^I should select courses except MISO-4206 and MISO-4331$/) do
  #No se si estoy seleccionando todos excepto las que necesito
  materias1=(1..6).to_a

  materias2=(1..8).to_a

  materias1.each do |mId|
    find(:css, "#materias1_[value='"<< mId.to_s<<"']").set(true)
  end

  page.find(:link,"Sem2").click

  materias2.each do |mId|
    find(:css, "#materias2_[value='"<< mId.to_s<<"']").set(true)
  end

  page.find(:link,"Sem3").click

  materias2.each do |mId|
    find(:css, "#materias3_[value='"<< mId.to_s<<"']").set(true)
  end

  page.find(:link,"Sem4").click

  materias2.each do |mId|
    find(:css, "#materias4_[value='"<< mId.to_s<<"']").set(true)
  end
  expect(page).to have_content('Materias del semestre 4')
end

Then(/^I should see al least 2 conflicts on the result page$/) do
  expect(page).to have_content('# conflictos 2')
end

Then(/^I should see the result page title$/) do
  expect(page).to have_content('Resultados')
end

Then(/^I should see "# conflictos"$/) do
  expect(page).to have_content('# conflictos')
end

Then(/^I should see "Estudiantes"$/) do
  expect(page).to have_content('Estudiantes')
end

Then(/^I should see "Consolidado Materias en conflicto"$/) do
  expect(page).to have_content('Consolidado Materias en conflicto')
end
