require 'swagger_helper'

RSpec.describe '用户相关的API', type: :request do

  path '/api/v1/users/create' do

    post 'Register User' do
      tags 'User', 'registration'
      produces 'application/json'

      parameter name: :request_params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, description: 'name' },
          nick_name: { type: :string, description: 'nick name' },
          email: { type: :string, description: 'email' },
          mobile: { type: :string, description: 'mobile' },
          password: { type: :string, description: 'password' }
        }
      }

      response '200', '用户创建成功' do
        let(:request_params) do {
          name: 'User1',
          mobile: '12345678901',
          password: 'password'
        }
        end

        after do |example|
          generate_example(example)
        end

        run_test!
      end
    end
  end
end
