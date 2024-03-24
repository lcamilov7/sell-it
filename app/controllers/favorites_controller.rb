class FavoritesController < ApplicationController
  def create
    # Favorite.create(product_id: product.id, user: Current.user)
    # product.favorites.create(user: Current.user)
    product.favorite! # Metodo de clase para el produto que crea un favorito para el producto con el Current.user! esta en el modelo de product
    redirect_to(product_path(product))
  end

  def destroy
    # Favorite.find_by(product_id: product.id, user: Current.user).destroy
    # product.favorites.find_by(user: Current.user).destroy
    product.unfavorite!
    redirect_to(product_path(product), status: :see_other)
  end

  private

  def product # memoization, cache para no tener que hacer una consulta en la base de datos cada vez que invocaos el metodo product
    # la variable @ debe tener el mismo nombre que el nombre del metodo
    @product ||= Product.find(params[:product_id])
  end
end
