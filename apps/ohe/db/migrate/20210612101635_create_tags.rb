##
## File Name    : 20210612101635_create_tags.rb
## Version      : v1.0
## Designer     : 籔本悠紀
## Date         : 2021.06.12
## Purpose      : タグのモデル
##

class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :tag_name

      t.timestamps
    end
  end
end
