class Chat < ApplicationRecord
  belongs_to :application

  belongs_to :application
  has_many :messages, dependent: :destroy

  before_create :assign_number

  private

  def assign_number
    self.number = (application.chats.maximum(:number) || 0) + 1
  end
end
