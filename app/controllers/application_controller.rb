class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_current_user
  before_action :protect_pages

  def set_current_user
    # Tiene que ser find by porque el find normal en caso de no encontrarlo salta error, y en find_by no
    # Lo que declaramos del modelo current estará disponible en toda la aplicación
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def protect_pages
    redirect_to(new_session_path, alert: 'You need o Log in or Sign up before continue') unless Current.user
  end
end
