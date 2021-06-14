class CreateUserInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :user_infos do |t|
      t.integer :user_id
      t.text :color_combination1
      t.text :color_combination2
      t.text :style

      t.timestamps
    end
  end
end
