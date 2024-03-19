class Product < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :photo, presence: true

  has_one_attached :photo
end
