class RenameMsgsCountInChats < ActiveRecord::Migration[7.2]
  def change
    rename_column :chats, :messages_count, :message_counter
  end
end
