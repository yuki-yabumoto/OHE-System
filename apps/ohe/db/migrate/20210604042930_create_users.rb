##
## File Name    : 20210604042930_create_users.rb
## Version      : 1.0
## Designer     : 籔本悠紀
## Purpose      : Userモデルのマイグレーションファイル
##

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password
      t.integer :gender
      t.string :place
      t.datetime :from_time
      t.datetime :to_time
      t.integer :favorite_color
      t.integer :favorite_type

      t.timestamps
    end

    add_index  :users, :email, unique: true
  end
end
