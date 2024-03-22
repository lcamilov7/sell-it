class CategoryPolicy < BasePolicy
  # todos los metodos de category controler queremos que esten protegidos asi que los declaramos todos los q hay en el
  # controlador

  # def index
  #   Current.user.admin
  # end

  # def new
  #   Current.user.admin
  # end

  # def create
  #   Current.user.admin
  # end

  # def edit
  #   Current.user.admin
  # end

  # def update
  #   Current.user.admin
  # end

  # def destroy
  #   Current.user.admin
  # end

  # Este metodo sobrescribe el mismo method_missing que herda de la clase padre y reemplaza todos los metodos comentados
  def method_missing(m, *args, &block) # Este metodo se ejecuta si se llama un metodo de clase que no existe, por seguridad
    Current.user.admin # ENvia true o false al metodo authorize dependeindo si es admin o no
  end
end
