class MessagesController < ApplicationController
    def create
        sen_params = params.permit(:body)

        @chat = Chat.select(:id).joins(:application).where(
                application: { token: params[:application_token] },
                number: params[:chat_number]
                )
        @message = Message.new({ chat_id: @chat.ids[0], body: sen_params[:body] })


        if @message.save
            render json: @message, status: :created, except: [ :id, :chat_id ]
        else
            render json: @message.errors, status: :unprocessable_entity
        end
    end

    def index
        @msgs = Message.joins(chat: [ :application ]).where(
                application: { token: params[:application_token] },
                chat: { number: params[:chat_number] }
                )

        render json: @msgs, except: [ :id, :chat_id ]
    end

    def search
        @msgs = Message.joins(chat: [ :application ]).where(
                application: { token: params[:application_token] },
                chat: { number: params[:chat_number] },
                  # messages: { body: params[:q] }
                ).where("messages.body LIKE ?", "%#{params[:q]}%")



        render json: @msgs, except: [ :id, :chat_id ]
    end

    def find_chat
        Application.find_by!(token: params[:application_token]).chats.find_by!(number: params[:chat_number])
    end
end
