class CreateChatsJob < ApplicationJob
  queue_as :default
  retry_on Exception


  def perform(*args)
    application_token = args[0][:application_token]
    application = Application.find_by!(token: application_token)

    @chat = application.chats.new()

    @chat.save!
  end
end
