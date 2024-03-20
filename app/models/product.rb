class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope(:global_search, against: { title: 'A', description: 'B' }, using: { tsearch: { prefix: true } })
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  # validates :photo, presence: true # Causa error en tests

  belongs_to :category
  has_one_attached :photo

end
