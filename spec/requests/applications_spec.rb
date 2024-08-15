require 'swagger_helper'

RSpec.describe 'applications', type: :request do
  path '/applications' do
    post('create application') do
      tags 'applications'

      consumes 'application/json'
      parameter name: :name, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Name#Foo' }
        }
      }

      response(201, 'successful') do
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

  path '/applications/{token}' do
    # You'll want to customize the parameter types...
    parameter name: 'token', in: :path, type: :string, description: 'token'

    get('show application') do
      tags 'applications'

      response(200, 'successful') do
        let(:token) { '123' }

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
    patch('update application') do
      tags 'applications'
      consumes 'application/json'
      parameter name: :name, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Name#Foo' }
        }
      }

      response(200, 'successful') do
        let(:token) { '123' }

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

    put('update application') do
      tags 'applications'
      consumes 'application/json'
      parameter name: :name, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Name#Foo' }
        }
      }

      response(200, 'successful') do
        let(:token) { '123' }

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
