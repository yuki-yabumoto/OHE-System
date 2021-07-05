##
## File Name    : 20210605025516_create_clothes.rb
## Version      : 1.0
## Designer     : 籔本悠紀
## Purpose      : Clotheモデルのマイグレーションファイル
##

class CreateClothes < ActiveRecord::Migration[6.1]
  def change
    create_table :clothes do |t|
      t.bigint :user_id
      t.integer :kind
      t.integer :color
      t.integer :type

      t.timestamps
    end
  end
end
