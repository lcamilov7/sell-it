class ProductsController < ApplicationController
  before_action :product, only: %i[show edit update destroy]
  skip_before_action :protect_pages, only: %i[index show]

  def index
    @categories = Category.order(name: :asc).load_async

    #@pagy, @products = pagy_countless(FindProducts.new.call(product_params_index), items: 12) # FindProducts.new.call(product_params_index) devuelve los productos ya que el metodo call de la clase FindProducts eso devuelve
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    # Le asignamos el producto creado al current user desde el modelo product!

    if @product.save
      redirect_to(product_path(@product), notice: 'Product created')
    else
      render :new, status: :unprocessable_entity # 422
    end
  end

  def edit
    authorize!(@product)
  end

  def update
    authorize!(@product)
    if @product.update(product_params)
      redirect_to(product_path(@product), notice: 'Product edited')
    else
      render :edit, status: :unprocessable_entity # 422
    end
  end

  def destroy
    authorize!(@product)
    @product.destroy!
    redirect_to(products_path, notice: 'Product deleted', status: :see_other)
  end

  private

  def product
    @product ||= Product.find(params[:id]) # Memoization para no tener que hacer una consulta a la base de datos cada vez que invoamos el metodo product
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end

  # Metodo para solo permitir recibir por params los atributos que le queremos permitir al usuario
  def product_params_index
    params.permit(:category_id, :min_price, :max_price, :query, :order, :page, :favorites, :user_id) # param favorites para el index de favorites con turframebotag, lo mismo para :user_id para el show de user
  end
end
