class ProductPolicy < BasePolicy
  # definimos los metodos de Products controller que necesitan autorizacion para ejecutarse [edit update destroy]
  def edit
    record.owner?
  end

  def update
    record.owner?
  end

  def destroy
    record.owner?
  end
end
