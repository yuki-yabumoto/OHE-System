class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password
      t.integer :gender
      t.date :from_time
      t.date :to_time
      t.integer :favorite_color
      t.integer :favorite_type

      t.timestamps
    end

    add_index  :users, :email, unique: true
  end
end
