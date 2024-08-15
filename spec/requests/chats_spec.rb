require 'swagger_helper'

RSpec.describe 'chats', type: :request do
  path '/applications/{application_token}/chats' do
    # You'll want to customize the parameter types...
    parameter name: 'application_token', in: :path, type: :string, description: 'application_token'


    post('create chat') do
      tags 'chats'

      response(201, 'successful') do
        let(:application_token) { '123' }

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

    get('list chats') do
      tags 'chats'

      response(200, 'successful') do
        let(:application_token) { '123' }

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

  path '/applications/{application_token}/chats/{number}' do
    # You'll want to customize the parameter types...
    parameter name: 'application_token', in: :path, type: :string, description: 'application_token'
    parameter name: 'number', in: :path, type: :string, description: 'number'

    get('show chat') do
    tags 'chats'

      response(200, 'successful') do
        let(:application_token) { '123' }
        let(:number) { '123' }

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
