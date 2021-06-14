class CreateCoordinates < ActiveRecord::Migration[6.1]
  def change
    create_table :coordinates do |t|
      t.bigint :tops
      t.bigint :bottoms
      t.bigint :outer
      t.bigint :shoes
      t.bigint :accessories

      t.timestamps
    end
  end
end
