Rails.application.config.after_initialize do
  CountChatsJob.perform_later
  CountMessagesJob.perform_later
end
