class UsersController < ApplicationController
  skip_before_action :protect_pages, only: %i[show]

  def show
    # Esta vez quiero hallar el usuario por username, no por su id
    @user = User.find_by!(username: params[:username]) # Param username lo definimos al crear la ruta en routes.rb, la exclamación lanza una excepcion por si meten un username que no existe
    # @pagy, @products = pagy_countless(FindProducts.new.call({ user_id: @user.id }), items: 12) # Ya no necesitamos esta linea porque estamos reciclando turbo frame tag en la vista de show user, la reciclamos del index de products pro le pasamos como param user_id y el metodo index devuelve products segun el param que se le pase
  end
end
