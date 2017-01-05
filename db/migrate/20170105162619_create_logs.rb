class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :action

      t.timestamps null: false
    end
  end
end
