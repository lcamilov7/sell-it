class ApplicationController < ActionController::Base
  include Authentication # Aca estan los metodos de autenticación set_current_user y protect_pages
  include Authorization # Aca está el metodo authorize!
  include Pagy::Backend
  # Debemos poner los include en orden, primero nos autenticamos, luego segun eso tendremos o no autorizaciones, luego
  # hacemos paginación con pagy
end
