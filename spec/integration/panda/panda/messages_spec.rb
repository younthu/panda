# frozen_string_literal: true

require 'swagger_helper'

describe '用户消息的API', type: :request, swagger_doc: 'v1/panda_swagger.yaml' do
  let(:user) { create(:user) }
  let(:Authorization) { user.secure_token }
  let(:panda_message) { create(:panda_message, receiver: user, sender: user, read: false) }
  let(:id) { panda_message.id }

  path "/api/v1/messages" do
    get '用户消息 列表' do # TODO: 加有session_id参数的case
      tags '用户消息'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
      parameter name: :session_id, in: :query, required: false, type: :string, description: 'session_id, 如果有这个参数，则只返回该session相关的历史记录.'

      response 200, '请求成功' do
        before do
          panda_message
        end

        after do |example|
          generate_example(example)
        end

        run_test! do
          expect_json_sizes(data: 1)
        end
      end
    end

    post '创建 用户消息' do
      tags '用户消息'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
      parameter name: :request_params, in: :body, schema: {
        type: :object,
        properties: {
          sender_type: { type: :string, description: 'sender_type'},
          sender_id: { type: :integer, description: 'sender_id'},
          receiver_type: { type: :string, description: 'receiver_type'},
          receiver_id: { type: :integer, description: 'receiver_id'},
          payload_type: { type: :string, description: 'payload_type'},
          payload_id: { type: :integer, description: 'payload_id'},
          body: { type: :string, description: 'body'},
          read: { type: :boolean, description: 'read'},
          session_id: { type: :string, description: 'session_id'},
          msg_type: { type: :string, description: 'msg_type'}
        }
      }

      response '200', '请求成功' do
        let(:request_params) {
          {
            sender_type: 'sender_type',
            sender_id: panda_message.sender_id,
            receiver_type: 'receiver_type',
            receiver_id: panda_message.receiver_id,
            payload_type: 'payload_type',
            payload_id: panda_message.payload_id,
            body: 'body',
            read: false,
            session_id: panda_message.session_id,
            msg_type: 'msg_type'
          }
        }

        after do |example|
          generate_example(example)
        end

        run_test!
      end
    end
  end

  path "/api/v1/messages/{id}" do
    get '用户消息 详情' do
      tags '用户消息'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
      parameter name: :id, in: :path, type: :string, description: 'id'
      
      response 200, '请求成功' do
        after do |example|
          generate_example(example)
        end

        run_test!
      end
    end

    delete '删除 用户消息' do
      tags '用户消息'
      produces 'application/json'
      consumes 'application/json'
      
      parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
      parameter name: :id, in: :path, type: :string, description: 'id'

      response 204, '请求成功' do
        run_test!
      end
    end

    put '更新 用户消息' do
      tags '用户消息'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
      parameter name: :id, in: :path, type: :string, description: 'id'
      parameter name: :request_params, in: :body, schema: {
        type: :object,
        properties: {
          sender_type: { type: :string, description: 'sender_type'},
          sender_id: { type: :integer, description: 'sender_id'},
          receiver_type: { type: :string, description: 'receiver_type'},
          receiver_id: { type: :integer, description: 'receiver_id'},
          payload_type: { type: :string, description: 'payload_type'},
          payload_id: { type: :integer, description: 'payload_id'},
          body: { type: :string, description: 'body'},
          read: { type: :boolean, description: 'read'},
          session_id: { type: :string, description: 'session_id'},
          msg_type: { type: :string, description: 'msg_type'}
        }
      }

      response '200', '请求成功' do
        let(:request_params) {
          {
            sender_type: panda_message.sender.class,
            sender_id: panda_message.sender_id,
            receiver_type: panda_message.receiver.class,
            receiver_id: panda_message.receiver_id,
            payload_type: panda_message.payload.class,
            payload_id: panda_message.payload_id,
            body: 'body',
            read: false,
            session_id: panda_message.session_id,
            msg_type: 'msg_type'
          }
        }

        after do |example|
          generate_example(example)
        end

        run_test! do
          expect_json('data', sender_type: 'User')
        end
      end
    end
  end

  path "/api/v1/messages/unread" do
    get "获取未读消息" do
      tags '用户消息'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
      parameter name: :session_id, in: :query, required: false, type: :string, description: 'session_id, 如果有这个参数，则只返回该session相关的历史记录.'
      parameter name: :mark_as_read, in: :query, required: false, type: :boolean, description: 'mark_as_read, 如果有这个参数，则只返回前把所有的消息标记为read: true'

      response 200, '请求成功' do 
        # TODO: 加有session_id参数的case
        # TODO: 加有mark_as_read参数的case.
        before do
          panda_message
        end

        after do |example|
          generate_example(example)
        end

        run_test! do |response|
          expect(response).to have_http_status(200)
          # expect(response).to have_content_type(:json)
          expect(response.body).to include('data')
          json = JSON.parse(response.body)
          expect_json_sizes(data: 1 ) # expect_json_sizes会自动parse response.body, 然后获取data的长度.
          expect_json_types(data: :array_of_objects) # https://github.com/brooklynDev/airborne
          expect_json('data.0', sender_type: 'User')
          expect_json('data.0', receiver_type: 'User')
          expect_json('data.0', read: false)
          
        end
      end

    end
  end
end
