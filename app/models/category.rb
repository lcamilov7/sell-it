class Category < ApplicationRecord
  # No permite eliminar categoria si hay productos asociados
  has_many :products, dependent: :restrict_with_exception

  validates :name, presence: true
end
