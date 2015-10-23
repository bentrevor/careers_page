class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.string :description
      t.integer :openings

      t.timestamps
    end
  end
end
