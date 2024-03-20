class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @categories = Category.order(name: :asc).load_async
    @products = Product.with_attached_photo # Soluciona error n + 1 query

    @products = Product.where(category_id: params[:category_id]) if params[:category_id].present?
    if params[:min_price].present? && params[:max_price].present?
      @products = @products.where("price >= #{params[:min_price]} AND price <= #{params[:max_price]}")
    elsif params[:min_price].present? && params[:max_price].blank?
      @products = @products.where("price >= #{params[:min_price]}")
    elsif params[:min_price].blank? && params[:max_price].present?
      @products = @products.where("price <= #{params[:max_price]}")
    end
    @products = @products.global_search(params[:query]) if params[:query].present?
    # if params[:order].present? no tenemos que verificar esta condicion porque
    # el metodo fetch lo verifica automaticamente y si no esta presente los ordena
    # segun el segundo parametro pasado del metodo fetch, en este caso created_at DESC
      order_by = {
        newest: 'created_at DESC',
        expensive: 'price DESC',
        cheap: 'price ASC'
      }.fetch(params[:order]&.to_sym, 'created_at DESC')
        # El & verifica si existe el params[:order], y si existe lo convierte a symbolo
        # si no lo ponemos tendremos un error ya que seria nil y nil no puede convertitse a sym
        # EL METODO FETCH CONVIERTE AL HASH EN UNA KEY VALUE SEGUN LA KEY PASADA COMO PRIMER
        # ARGUMENTO, SI NO HAY PRIMER ARGUMENTO (&) ENTONCES CONVIERTE EL HASH EN EL SEGUNDO ARGUMENTO
      @products = @products.order(order_by).load_async
    # end
    # En una consulta solo podemos tener un metodo .order, si hay 2, no funciona,
    # .order va al final. y el metodo load_async tiene que ser el ultimo de todos,
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to(product_path(@product), notice: 'Product created')
    else
      render :new, status: :unprocessable_entity # 422
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to(product_path(@product), notice: 'Product edited')
    else
      render :edit, status: :unprocessable_entity # 422
    end
  end

  def destroy
    @product.destroy!
    redirect_to(products_path, notice: 'Product deleted', status: :see_other)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end
end
