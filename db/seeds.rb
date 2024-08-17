# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Clear existing data
Message.destroy_all
Chat.destroy_all
Application.destroy_all

# Create Applications
app1 = Application.create!(name: "Chat App Alpha", token: SecureRandom.uuid)
app2 = Application.create!(name: "Chat App Beta", token: SecureRandom.uuid)

# Create Chats for Application 1
chat1_app1 = app1.chats.create!()
chat2_app1 = app1.chats.create!()

# Create Chats for Application 2
chat1_app2 = app2.chats.create!()
chat2_app2 = app2.chats.create!()

# Create Messages for Chats in Application 1
chat1_app1.messages.create!(body: "Hello from chat 1 in App Alpha")
chat1_app1.messages.create!(body: "How are you doing in chat 1, App Alpha?")

chat2_app1.messages.create!(body: "Welcome to chat 2 in App Alpha")
chat2_app1.messages.create!(body: "Chat 2 is awesome in App Alpha!")

# Create Messages for Chats in Application 2
chat1_app2.messages.create!(body: "Hello from chat 1 in App Beta")
chat1_app2.messages.create!(body: "How are you doing in chat 1, App Beta?")

chat2_app2.messages.create!(body: "Welcome to chat 2 in App Beta")
chat2_app2.messages.create!(body: "Chat 2 is awesome in App Beta!")
