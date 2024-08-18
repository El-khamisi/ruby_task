class CreateMessagesJob < ApplicationJob
  queue_as :default
  retry_on Exception


  def perform(*args)
    application_token = args[0][:application_token]
    chat_number = args[0][:chat_number]
    msg_body = args[0][:msg_body]

    @chat = Chat.select(:id).joins(:application).where(
      application: { token: application_token },
      number: chat_number
      )
    @message = Message.new({ chat_id: @chat.ids[0], body: msg_body })

    @message.save!
  end
end
