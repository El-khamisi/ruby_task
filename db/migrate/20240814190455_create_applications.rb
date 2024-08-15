class CreateApplications < ActiveRecord::Migration[7.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :token, null: false, index: { unique: true }
      t.integer :chats_count, default: 0

      t.timestamps
    end
  end
end
