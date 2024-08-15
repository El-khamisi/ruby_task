class ChatsController < ApplicationController
  def create
    application = Application.find_by!(token: params[:application_token])

    @chat = application.chats.new()

    if @chat.save
      render json:  @chat, except: [ :id, :application_id ], status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
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
