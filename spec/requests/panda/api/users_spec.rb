require 'swagger_helper'

RSpec.describe '用户相关的API', type: :request, swagger_doc: 'v1/panda_swagger.yaml' do

  path '/api/v1/users/create' do

    post 'Register User' do
      tags 'User', 'registration'
      produces 'application/json'
      consumes "application/json"

      parameter name: 'name', in: :path, type: :string, description: 'name'
      parameter name: 'nick_name', in: :query, type: :string, required: false, description: 'nick name'
      parameter name: 'email', in: :query, type: :string, description: 'email'
      parameter name: 'mobile', in: :query, type: :string, required: false, description: 'mobile'
      parameter name: 'password', in: :query, type: :integer, description: 'password'

      response '200', 'email用户创建成功' do
        let(:name) {'User1'}
        let(:email) {'test@test.com'}
        let(:password) {'password'}

        after do |example|
          generate_example(example)
        end

        run_test! do |response|
          expect(response).to have_http_status(200)
          # expect(response).to have_content_type(:json)
          expect(response.body).to include('auth_token')
        end
      end
    end
  end
end
