class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope(:global_search, against: { title: 'A', description: 'B' }, using: { tsearch: { prefix: true } })

  belongs_to :category
  belongs_to :user, default: -> { Current.user }
  has_one_attached :photo

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  # validates :photo, presence: true # Causa error en tests

  ORDER_BY = {
    newest: 'created_at DESC',
    expensive: 'price DESC',
    cheap: 'price ASC'
  }

  def owner?
    self.user.id == Current.user&.id # Es importante este & para cuando no haya un current user no salga error
  end
end
