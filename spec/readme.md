1. rails generate rspec:swagger Panda::Api::UsersController, it generates an empty spec.
2. `rails generate rspec:model user`, 
   1. more generators, please check https://github.com/rspec/rspec-rails/blob/main/features/Generators.md 
3. `rspec --format Rswag::Specs::SwaggerFormatter --order defined`, 生成swagger.
4. https://github.com/brooklynDev/airborne,  expect_json的用法.
5. 文档分类，在post里面加`tags '用户消息'`
6. 指定swagger doc文件名: `describe '用户消息的API', type: :request, swagger_doc: 'v1/panda_swagger.yaml'`
7. spec 参数
  ~~~ruby
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
   ~~~