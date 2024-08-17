class Message < ApplicationRecord
  belongs_to :chat

  before_create :assign_number

  searchkick callbacks: :async, text_middle: [ :body ]

  private

  def assign_number
    self.number = (chat.messages.maximum(:number) || 0) + 1
  end
end
