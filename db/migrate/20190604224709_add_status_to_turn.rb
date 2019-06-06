class AddStatusToTurn < ActiveRecord::Migration[5.1]
  def change
    add_column :turns, :status, :string, default: 'pending'
  end
end
