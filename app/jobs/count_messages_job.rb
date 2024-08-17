class CountMessagesJob < ApplicationJob
  queue_as :default
  retry_on Exception, wait: 1.hour, attempts: :unlimited


  def perform(*args)
    chats = Chat.all()

    chats.each do |chat|
        messages = Message.where(chat_id: chat.id).count

        begin
          chat.update(message_counter: messages)
        rescue => e
          logger.error "Failed to update chat #{chat.id}: #{e.message}"
        end
    end



    CountMessagesJob.set(wait: 1.hour).perform_later
  end
end
