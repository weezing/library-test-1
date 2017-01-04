class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :pages
      t.integer :year
      t.integer :quantity
      t.integer :current_quantity

      t.timestamps null: false
    end
  end
end
