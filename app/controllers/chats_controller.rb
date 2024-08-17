class ChatsController < ApplicationController
  def create
    CreateChatsJob.perform_later(application_token: params[:application_token])

    render json: {}, status: :created
  end

  def show
    @chat = find_chat

    render json: @chat, except: [ :id ]
  end

  def index
    application = Application.find_by!(token: params[:application_token])
    @chats = application.chats

    render json: @chats, except: [ :id, :application_id ]
  end


  def find_chat
    Application.find_by!(token: params[:application_token]).chats.find_by!(number: params[:number])
  end
end
