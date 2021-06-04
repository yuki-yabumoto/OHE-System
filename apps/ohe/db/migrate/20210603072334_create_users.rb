class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password
      t.string :gender
      t.date :going_out_time
      t.integer :favorite_color
      t.integer :favorite_style

      t.timestamps
    end
  end
end
