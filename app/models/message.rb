class Message < ApplicationRecord
  belongs_to :chat

  before_create :assign_number

  private

  def assign_number
    self.number = (chat.messages.maximum(:number) || 0) + 1
  end
end
