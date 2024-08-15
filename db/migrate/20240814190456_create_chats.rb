class CreateChats < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.references :application, null: false, foreign_key: true
      t.integer :number, null: false
      t.integer :messages_count

      t.timestamps
    end
    add_index :chats, [ :application_id, :number ], unique: true
  end
end
