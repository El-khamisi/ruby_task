require 'swagger_helper'

RSpec.describe 'messages', type: :request do
  path '/applications/{application_token}/chats/{chat_number}/messages/search' do
    # You'll want to customize the parameter types...
    parameter name: 'application_token', in: :path, type: :string, description: 'application_token'
    parameter name: 'chat_number', in: :path, type: :string, description: 'chat_number'
    parameter name: 'q', in: :query, type: :string, description: 'search query'

    get('search message') do
      tags 'chats'

      response(200, 'successful') do
        let(:application_token) { '123' }
        let(:chat_number) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats/{chat_number}/messages' do
    # You'll want to customize the parameter types...
    parameter name: 'application_token', in: :path, type: :string, description: 'application_token'
    parameter name: 'chat_number', in: :path, type: :string, description: 'chat_number'

    get('list messages') do
      tags 'messages'

      response(200, 'successful') do
        let(:application_token) { '123' }
        let(:chat_number) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create message') do
      tags 'messages'

      consumes 'application/json'
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string, example: 'example message body' }
        }
      }

      response(200, 'successful') do
        let(:application_token) { '123' }
        let(:chat_number) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
