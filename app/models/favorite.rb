class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user, uniqueness: { scope: :product } # Solo un favorito por producto del mismo usuario a nivel de cliente
end
