module Favoritable
  extend ActiveSupport::Concern

  included do
    def favorite! # Exclamación significa que vamos a hacer cambios
      self.favorites.create(user: Current.user)
    end

    def find_favorite
      self.favorites.find_by(user_id: Current.user.id)
    end

    def unfavorite! # Exclamación significa que vamos a hacer cambios
      find_favorite.destroy
    end
  end
end
