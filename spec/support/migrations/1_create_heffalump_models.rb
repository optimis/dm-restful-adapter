class CreateHeffalumpModels < ActiveRecord::Migration
  def change
    create_table :heffalump_models do |t|
      t.string :color
      t.integer :num_spots
      t.boolean :striped
    end
  end
end
