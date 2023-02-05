# frozen_string_literal: true

FactoryBot.define do
  factory :panda_message, class: 'Panda::Message' do
    read { true}
  end
end
