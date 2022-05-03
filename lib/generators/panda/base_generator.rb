# frozen_string_literal: true

module Panda::BaseGenerator
  def singular_plural_name
    plural_name.singularize
  end

  def classify_name
    plural_name.classify
  end

  def classify_scope
    scope.classify
  end

  def pluralize_scope
    classify_name.pluralize
  end

  def render
    options['render']
  end

  def scope
    class_path[0]
  end

  def chinese_name
    options['name']
  end

  def admin_index_column
    origin_columns.map do |column|
      "column :#{column.name}"
    end.join("\n    ")
  end

  def properties
    columns.map do |column|
      case column.type.to_s
      when 'text'
        "#{column.name}: { type: :string, description: '#{column.name}'}"
      when 'float', 'decimal'
        "#{column.name}: { type: :number, description: '#{column.name}'}"
      else
        "#{column.name}: { type: :#{column.type}, description: '#{column.name}'}"
      end
    end.join(",\n          ")
  end

  def request_params
    columns.map do |column|
      next if column.name == 'id'

      if column.name.index('_id')
        "#{column.name}: #{singular_plural_name}.#{column.name}"
      else
        case column.type.to_s
        when 'string'
          "#{column.name}: '#{column.name}'"
        when 'decimal'
          "#{column.name}: 3.33"
        when 'integer'
          "#{column.name}: 6"
        when 'float'
          "#{column.name}: 9.99"
        when 'boolean'
          "#{column.name}: false"
        else
          "#{column.name}: '#{column.name}'"
        end
      end
    end.compact.join(",\n            ")
  end

  def columns
    origin_columns.delete_if { |column| column.name.in? %(id created_at updated_at) }
  end

  def origin_columns
    singular_plural_name.camelize.constantize.columns.dup
  end
end
