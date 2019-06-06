class AddConsultingRoomIdToTurn < ActiveRecord::Migration[5.1]
  def change
    add_column :turns, :consulting_room_id, :integer
  end
end
