Given(/^I am on the plannings page$/) do
  visit '/reservas/home'
end

Then(/^I press "Si"$/) do
  expect(page).to have_content('Desea especificar las materias en cada semestre')
  page.find(:link,"Si").click
end

Then(/^I presss "Ejecutar planeacion"$/) do
  page.find(:link,"Ejecutar planeacion").click
end

Then(/^I select some courses in each semester$/) do

  materias1=(1..4).to_a

  materias2=(5..8).to_a

  materias1.each do |mId|
    find(:css, "#materias1_"<< mId.to_s).set(true)
  end

  page.find(:link,"Siguiente1").click

  materias2.each do |mId|
    find(:css, "#materias2_"<< mId.to_s).set(true)
  end

  page.find(:link,"Siguiente2").click

  materias1.each do |mId|
    find(:css, "#materias3_"<< mId.to_s).set(true)
  end

  page.find(:link,"Siguiente3").click

  materias2.each do |mId|
    find(:css, "#materias4_"<< mId.to_s).set(true)
  end

  expect(page).to have_content('Planeacion Semestre 4')
end

Then(/^I execute the planning$/) do
  click_button ("Terminar")
end

Then(/^I should see a valid planning over the courses I selected in each semester$/) do
  sem1=true
  plans=Planeacion.where("semestre='1' OR semestre='3'")
  plans.each do |p|

    if(p.codigoMateria.to_i>4)
      sem1=false
    end
  end

  sem2=true
  plans=Planeacion.where("semestre='2' OR semestre='4'")
  plans.each do |p|
    if(p.codigoMateria.to_i<=4)
      sem2=false
    end
  end


  assert (sem1 && sem2)
end

Then (/^I should see "Planeacion Semestre 1"$/) do
  expect(page).to have_content('Planeacion Semestre 1')
end
Then (/^I should see "Planeacion Semestre 2"$/) do
  expect(page).to have_content('Planeacion Semestre 2')
end
Then (/^I should see "Planeacion Semestre 3"$/) do
  expect(page).to have_content('Planeacion Semestre 3')
end
Then (/^I should see "Planeacion Semestre 4"$/) do
  expect(page).to have_content('Planeacion Semestre 4')
end

Then(/^I should see all the courses$/) do
  materias= Materia.all
  materias.each do |m|
    expect(page).to have_content(m.nombre)
  end 
end
Then (/^I select some courses (\d+)$/) do |arg1|
  materias1=(1..4).to_a

  materias2=(5..8).to_a

  materias1.each do |mId|
    find(:css, "#materias"<<arg1.to_s<<"_"<< mId.to_s).set(true)
  end

end

Then(/^I press "Siguiente" (\d+)$/) do |arg1|
  page.find(:link,"Siguiente"<<arg1.to_s).click
end

Then(/^I press "Terminar"$/) do
  click_button ("Terminar")
end
Then(/^I should see "Resultados"$/) do 
  expect(page).to have_content('Resultados')
end

