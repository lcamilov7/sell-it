class FindProducts   # Capitulo 30 aprendev
  attr_reader :products

  def initialize(products = initial_scope) # Si no se le pasa nada al crear una nueva instancia FindProducts.new(vacio), entonces products = initial_scope
    @products = products
  end

  # Metodo de la llamada de búsqueda
  def call(params = {})
    scoped = products # products es @products gracias al attr_reader porque def products; @products; end
    scoped = filter_by_category_id(scoped, params[:category_id])
    scoped = filter_by_price(scoped, params[:min_price], params[:max_price])
    scoped = filter_by_query(scoped, params[:query])
    return sort(scoped, params[:order])
  end

  private

  def initial_scope
    Product.with_attached_photo # with_attached_photo soluciona error n + 1 query
  end

  # IMPORTANTISIMO PONER EL .present? O EL blank?
  
  def filter_by_category_id(scoped, category_id)
    return scoped unless category_id.present? # Devolvemos los mismos productos a menos que exista un param para category_id

    return scoped.where(category_id: category_id)
  end

  def filter_by_price(scoped, min_price, max_price)
    if min_price.present? && max_price.present?
      scoped = scoped.where("price >= #{min_price} AND price <= #{max_price}")
    elsif min_price.present? && max_price.blank?
      scoped = scoped.where("price >= #{min_price}")
    elsif min_price.blank? && max_price.present?
      scoped = scoped.where("price <= #{max_price}")
    end
    return scoped
  end

  def filter_by_query(scoped, query)
    return scoped unless query.present?

    return scoped.global_search(query)
  end

  def sort(scoped, order_by)
    ### if params[:order].present? no tenemos que verificar esta condicion que es igual tambien a order_by.present? ya que order_by es igual a params[:order]. porque
      # el metodo fetch lo verifica automaticamente y si no esta presente los ordena
      # segun el segundo parametro pasado del metodo fetch, en este caso created_at DESC
    order_by_query = Product::ORDER_BY.fetch(order_by&.to_sym, 'created_at DESC')
      # El & verifica si existe el params[:order] en este caso order_by, y si existe lo convierte a symbolo
      # si no lo ponemos tendremos un error ya que seria nil y nil no puede convertitse a sym
      # EL METODO FETCH CONVIERTE AL HASH EN UNA KEY VALUE SEGUN LA KEY PASADA COMO PRIMER
      # ARGUMENTO, SI NO HAY PRIMER ARGUMENTO (&) ENTONCES CONVIERTE EL HASH EN EL SEGUNDO ARGUMENTO
    return scoped.order(order_by_query) # .load_async no funciona
  ### end
  # En una consulta solo podemos tener un metodo .order, si hay 2, no funciona,
  # .order va al final. y el metodo load_async tiene que ser el ultimo de todos,
  end
end
