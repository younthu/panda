# frozen_string_literal: true

require 'swagger_helper'

describe '通知消息 API', type: :request, swagger_doc: 'panda/swagger.json' do
  let(:user) { create(:user) }
  let(:Authorization) { user.secure_token }
  let(:panda_notification) { create(:panda_notification, sender: user) }
  let(:id) { panda_notification.id }

  path "/api/v1/notifications" do
    get '通知消息 列表' do
      tags '通知消息'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: '用户认证'

      response 200, '请求成功' do
        before do
          panda_notification
        end

        after do |example|
          generate_example(example)
        end

        run_test! do
          expect_json_sizes(data: 1)
        end
      end
    end

    post '创建 通知消息' do
      tags '通知消息'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
      parameter name: :request_params, in: :body, schema: {
        type: :object,
        properties: {
          sender_type: { type: :string, description: 'sender_type'},
          sender_id: { type: :integer, description: 'sender_id'},
          receiver_id: { type: :integer, description: 'receiver_id'},
          payload_type: { type: :string, description: 'payload_type'},
          payload_id: { type: :integer, description: 'payload_id'},
          body: { type: :string, description: 'body'},
          read: { type: :boolean, description: 'read'},
          type: { type: :string, description: 'type'}
        }
      }

      response '200', '请求成功' do
        let(:request_params) {
          {
            sender_type: 'sender_type',
            sender_id: panda_notification.sender_id,
            receiver_id: panda_notification.receiver_id,
            payload_type: 'payload_type',
            payload_id: panda_notification.payload_id,
            body: 'body',
            read: false,
            type: 'type'
          }
        }

        after do |example|
          generate_example(example)
        end

        run_test!
      end
    end
  end

  path "/panda/panda/notifications/{id}" do
    get '通知消息 详情' do
      tags '通知消息'
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

    delete '删除 通知消息' do
      tags '通知消息'
      produces 'application/json'
      consumes 'application/json'
      
      parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
      parameter name: :id, in: :path, type: :string, description: 'id'

      response 204, '请求成功' do
        run_test!
      end
    end

    put '更新 通知消息' do
      tags '通知消息'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
      parameter name: :id, in: :path, type: :string, description: 'id'
      parameter name: :request_params, in: :body, schema: {
        type: :object,
        properties: {
          sender_type: { type: :string, description: 'sender_type'},
          sender_id: { type: :integer, description: 'sender_id'},
          receiver_id: { type: :integer, description: 'receiver_id'},
          payload_type: { type: :string, description: 'payload_type'},
          payload_id: { type: :integer, description: 'payload_id'},
          body: { type: :string, description: 'body'},
          read: { type: :boolean, description: 'read'},
          type: { type: :string, description: 'type'}
        }
      }

      response '200', '请求成功' do
        let(:request_params) {
          {
            sender_type: 'sender_type',
            sender_id: panda_notification.sender_id,
            receiver_id: panda_notification.receiver_id,
            payload_type: 'payload_type',
            payload_id: panda_notification.payload_id,
            body: 'body',
            read: false,
            type: 'type'
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
