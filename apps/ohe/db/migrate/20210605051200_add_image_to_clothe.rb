##
## File Name    : 20210605051200_add_image_to_clothe.rb
## Version      : 1.0
## Designer     : 籔本悠紀
## Date         : 2021.06.05
## Purpose      : Clotheモデルに画像を追加
##

class AddImageToClothe < ActiveRecord::Migration[6.1]
  def change
    add_column :clothes, :image, :string
  end
end
