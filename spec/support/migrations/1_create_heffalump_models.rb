class CreateHeffalumpModels < ActiveRecord::Migration
  def change
    create_table :heffalump_models do |t|
      t.string :color
      t.integer :num_spots
      t.boolean :striped
      t.timestamps
    end
  end
end
