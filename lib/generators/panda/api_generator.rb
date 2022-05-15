# frozen_string_literal: true

require_relative 'base_generator'
require 'fileutils'

class Panda::ApiGenerator < Rails::Generators::NamedBase
  include Panda::BaseGenerator

  source_root File.expand_path('swagger/templates', __dir__)

  class_option :name, type: :string, default: 'plural_name'
  class_option :module, type: :string, default: '' # 这个API放哪个目录(module)下, 可以用'/'来制定子目录


  def module_prefix
    options['module'].present? ? "#{options['module'].capitalize}::" : ""
  end

  def folder_prefix
    options['module'].present? ? "#{options['module']}/" : ""
  end

  # create_打头的方法会被自动call到, When a generator is invoked, each public method in the generator is executed sequentially in the order that it is defined. Finally, we invoke the create_file method that will create a file at the given destination with the given content. If you are familiar with the Rails Application Templates API, you'll feel right at home with the new generators API.
  desc "创建api controller, rspec文件和admin文件"
  def create_swagger_file
    unless Class.const_defined?(classify_name)
      puts "请先执行 rails g model 生成对应model"
      return
    end

    create_file "app/admin/#{plural_name}.rb", <<~FILE
      # frozen_string_literal: true

      ActiveAdmin.register #{classify_name} do
        index do
          #{admin_index_column}

          actions
        end
      end

    FILE

    create_file "app/controllers/#{folder_prefix}#{plural_name}_controller.rb", <<~FILE
      # frozen_string_literal: true
        class #{module_prefix}#{classify_name.pluralize}Controller < ApplicationController
          expose(:result) { #{classify_name}.find(params[:id]) }
          expose(:payload) { #{classify_name}.params_permit(params) }

          def show
            result

            render :intelligence
          end

          def index
            @result = #{classify_name}.recent.page(page).per(per)

            paginate @result

            render :intelligence
          end

          def create
            @result = #{classify_name}.create! payload

            render :intelligence
          end

          def update
            result.update payload

            render :intelligence
          end

          def destroy
            result.destroy

            head 204
          end
        end

    FILE

    create_file "spec/integration/#{scope}/#{plural_name}_spec.rb", <<~FILE
      # frozen_string_literal: true

      require 'swagger_helper'

      describe '#{chinese_name} API', type: :request, swagger_doc: '#{scope}/swagger.json' do
        let(:user) { create(:user) }
        let(:Authorization) { user.auth_token }
        let(:#{singular_plural_name_no_slash}) { create(:#{singular_plural_name_no_slash}, user: user) }
        let(:id) { #{singular_plural_name_no_slash}.id }

        path "/#{scope}/#{plural_name}" do
          get '#{chinese_name} 列表' do
            tags '#{chinese_name}'
            produces 'application/json'
            consumes 'application/json'

            parameter name: :Authorization, in: :header, type: :string, description: '用户认证'

            response 200, '请求成功' do
              before do
                #{singular_plural_name_no_slash}
              end

              after do |example|
                generate_example(example)
              end

              run_test! do
                expect_json_sizes(data: 1)
              end
            end
          end

          post '创建 #{chinese_name}' do
            tags '#{chinese_name}'
            produces 'application/json'
            consumes 'application/json'

            parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
            parameter name: :request_params, in: :body, schema: {
              type: :object,
              properties: {
                #{properties}
              }
            }

            response '200', '请求成功' do
              let(:request_params) {
                {
                  #{request_params}
                }
              }

              after do |example|
                generate_example(example)
              end

              run_test!
            end
          end
        end

        path "/#{scope}/#{plural_name}/{id}" do
          get '#{chinese_name} 详情' do
            tags '#{chinese_name}'
            produces 'application/json'
            consumes 'application/json'

            parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
            parameter name: :id, in: :path, type: :string, description: 'id'
      #{'      '}
            response 200, '请求成功' do
              after do |example|
                generate_example(example)
              end

              run_test!
            end
          end

          delete '删除 #{chinese_name}' do
            tags '#{chinese_name}'
            produces 'application/json'
            consumes 'application/json'
      #{'      '}
            parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
            parameter name: :id, in: :path, type: :string, description: 'id'

            response 204, '请求成功' do
              run_test!
            end
          end

          put '更新 #{chinese_name}' do
            tags '#{chinese_name}'
            produces 'application/json'
            consumes 'application/json'

            parameter name: :Authorization, in: :header, type: :string, description: '用户认证'
            parameter name: :id, in: :path, type: :string, description: 'id'
            parameter name: :request_params, in: :body, schema: {
              type: :object,
              properties: {
                #{properties}
              }
            }

            response '200', '请求成功' do
              let(:request_params) {
                {
                  #{request_params}
                }
              }

              after do |example|
                generate_example(example)
              end

              run_test! do
                expect_json('data', #{columns.first.name}: '#{columns.first.name}')
              end
            end
          end
        end
      end
    FILE

    FileUtils.remove_dir("spec/models", force: true) if File.exist? "spec/models"
  end
end
