# frozen_string_literal: true

require 'swagger_helper'

describe '用户消息 API', type: :request, swagger_doc: 'panda/swagger.json' do
  let(:user) { create(:user) }
  let(:Authorization) { user.auth_token }
  let(:panda_message) { create(:panda_message, user: user) }
  let(:id) { panda_message.id }

  path "/panda/panda/messages" do
    get '用户消息 列表' do
      tags '用户消息'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: '用户认证'

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

  path "/panda/panda/messages/{id}" do
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

        run_test! do
          expect_json('data', sender_type: 'sender_type')
        end
      end
    end
  end
end
