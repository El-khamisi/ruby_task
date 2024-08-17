class RenameChatsCountInApplications < ActiveRecord::Migration[7.2]
  def change
    rename_column :applications, :chats_count, :chat_counter
  end
end
