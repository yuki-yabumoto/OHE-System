class CreateCoordinates < ActiveRecord::Migration[6.1]
  def change
    create_table :coordinates do |t|
      t.bigint :user_id
      t.bigint :tops
      t.bigint :bottoms
      t.bigint :outer
      t.bigint :shoes
      t.bigint :accessory

      t.timestamps
    end
  end
end
