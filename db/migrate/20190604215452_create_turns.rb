class CreateTurns < ActiveRecord::Migration[5.1]
  def change
    create_table :turns do |t|
      t.integer :code
      t.integer :specialty
      t.string :cc

      t.timestamps
    end
  end
end
