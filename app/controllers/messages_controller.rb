class MessagesController < ApplicationController
    def create
        CreateMessagesJob.perform_later(application_token: params[:application_token], chat_number: params[:chat_number], msg_body: params[:body])

        render json: {}, status: :created
    end

    def index
        @msgs = Message.joins(chat: [ :application ]).where(
                application: { token: params[:application_token] },
                chat: { number: params[:chat_number] }
                )

        render json: @msgs, except: [ :id, :chat_id ]
    end

    def search
        # @msgs = Message.joins(chat: [ :application ]).where(
        #         application: { token: params[:application_token] },
        #         chat: { number: params[:chat_number] },
        #         ).where("messages.body LIKE ?", "%#{params[:q]}%")

        @chat = Chat.select(:id).joins(:application).where(
            application: { token: params[:application_token] },
            number: params[:chat_number]
            )
        @eresults = Message.search(params[:q], fields: [ :body ], match: :text_middle,
        where: { chat_id: @chat.ids[0] },
        order: { created_at: :desc })

        @msgs = @eresults.each { |e| e }

        render json: @msgs, except: [ :id, :chat_id ]
    end

    def find_chat
        Application.find_by!(token: params[:application_token]).chats.find_by!(number: params[:chat_number])
    end
end
