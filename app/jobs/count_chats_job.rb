class CountChatsJob < ApplicationJob
  queue_as :default
  retry_on Exception, wait: 1.hour, attempts: :unlimited

  def perform(*args)
    applications = Application.all()

    applications.each do |application|
        chats = Chat.where(application_id: application.id).count

        begin
          application.update(chat_counter: chats)
        rescue => e
          logger.error "Failed to update application #{application.id}: #{e.message}"
        end
    end



    CountChatsJob.set(wait: 1.hour).perform_later
  end
end
