class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    # Este add index nos permite evitar que a un usuario le guste un producto 2 veces, a nivel de base de datos
    add_index :favorites, [:user_id, :product_id], unique: true
  end
end
