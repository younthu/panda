# frozen_string_literal: true

module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body).with_indifferent_access
    end
  end
end

def generate_example(example)
  example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
end
