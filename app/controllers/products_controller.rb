class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all
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
    params.require(:product).permit(:title, :description, :price, :photo)
  end
end
