class CreateRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :requests do |t|
      t.string :make
      t.string :model
      t.integer :year
      t.integer :mileage

      t.timestamps
    end
  end
end
