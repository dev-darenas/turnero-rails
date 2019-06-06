class CreateConsultingRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :consulting_rooms do |t|
      t.string :name

      t.timestamps
    end
  end
end
