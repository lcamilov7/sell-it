class User < ApplicationRecord
  has_secure_password # Añade todos los metodos de contraseña encryptada y login y descomentamos gema bcrypt
  has_one_attached :avatar

  validates :email, presence: true, uniqueness: true,
    format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: :invalid
    }
  validates :username, presence: true, uniqueness: true, length: { in: 6..15 },
    format: {
      with: /\A[a-z-0-9-A-Z]+\z/, message: :invalid
    }
  validates :password, length: { minimum: 6 }

  before_save :downcase_attr

  def downcase_attr
    self.username = self.username.downcase
    self.email = self.email.downcase
  end
end
