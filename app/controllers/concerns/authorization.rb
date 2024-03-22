module Authorization
  extend ActiveSupport::Concern

  included do
    class NotAuthorizedError < StandardError; end

    rescue_from NotAuthorizedError do
      redirect_to(products_url, alert: 'Invalid url') # Esto hace que se redireccione a products_url cuando se invoca este error
    end

    private

    def authorize!(record = nil)
      # if record # si se pasa un record como parametrso significa que es un producto entonces aplicamos logica para el producto
      #   is_allowed = record.user == Current.user
      # else
      #   is_allowed = Current.user.admin
      # end

      is_allowed = "#{controller_name.singularize.capitalize}Policy".constantize.new(record).send(action_name) # Aca creamos el nombre de la clase que vamos a invocar, si el controller name es products significa q estan llamando al metodo authorize desde products, osea que controller_name devuelve 'products', pero nuestra policy se llama ProductPolicy, entonces tenemos que quitarle el plural y ponerle mayuscula y tendremos ya el nombre de la clase que necesitamos invocar (carpeta policies), luego convertimos el string a constante porque al string no lo podemos usar para invocar una clase, luego creamos la instancia de la clase policy con .new, luego necesitamos saber desde que metodo se esta llamando al metodo authorize y lo sabremos con .send(action_name)
      raise NotAuthorizedError unless is_allowed # Invocamos el raise para que la logica q seguia despues por ejemplo en el metodo products update no se siga ejecutando
    end
  end
end
