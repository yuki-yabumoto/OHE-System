class CreateTagMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_maps do |t|
      t.bigint :user_id
      t.bigint :clothe_id
      t.bigint :tag_id

      t.timestamps
    end
  end
end
