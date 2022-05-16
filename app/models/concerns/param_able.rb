# frozen_string_literal: true

module ParamAble
  extend ActiveSupport::Concern

  included do
    def self.params_permit(params, excepts = [], additions = [])
      excepts << model_name.i18n_key
      params.except(*excepts).permit(permit_params + additions)
    end

    def self.permit_params
      column_names.map(&:to_sym) - %i[id updated_at created_at]
    end
  end
end
