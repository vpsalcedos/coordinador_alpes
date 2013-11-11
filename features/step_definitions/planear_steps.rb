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
    find(:css, "#materias1_[value='"<< mId.to_s<<"']").set(true)
  end

  page.find(:link,"Sem2").click

  materias2.each do |mId|
    find(:css, "#materias2_[value='"<< mId.to_s<<"']").set(true)
  end

  page.find(:link,"Sem3").click

  materias1.each do |mId|
    find(:css, "#materias3_[value='"<< mId.to_s<<"']").set(true)
  end

  page.find(:link,"Sem4").click

  materias2.each do |mId|
    find(:css, "#materias4_[value='"<< mId.to_s<<"']").set(true)
  end

  expect(page).to have_content('Materias del semestre 4')
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


