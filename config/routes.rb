CoordinadorAlpes::Application.routes.draw do
  get "dashboard/dashboard"
  get "planeacion/resultados"
  get "materia/detalles"
  post "materia/listafiltrada"
  get "materia/infomateria"
  get "estudiante/infoestudiante"
  post "estudiante/listafiltrada"
  get "generar_secciones/generar"
  post "generar_secciones/generarSecciones"

  get "materia/cupos"
  get "estudiante/cuposmas8"
  get "welcome/index"
  get "reservas/ultimosEstudiantes"
  get "reservas/reservasUltimosEst"
  get "reservas/limpiarEscenario"
  get "reservas/home"
  get "reservas/planearSemestres"
  get "reservas/semestrePlaneado"
  get "reservas/detalles"

  get "estudiante/buscarEstudiantesMasOcho"
  post "estudiante/creditosfaltantes"

  get "estado_carpeta/estadoCarpeta"
  get "estado_carpeta/carpeta"
  get "estudiante/result"
  get "materia/new"
  get "estudiante/new"
  get "users/new"

  get "estado_carpeta/home"
  post "estado_carpeta/estadoCarpeta"
  post "reservas/setMateriasSemestre"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
