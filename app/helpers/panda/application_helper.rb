# frozen_string_literal: true

module Panda::ApplicationHelper
  include ActiveSupport::NumberHelper

  # 标准渲染
  def render_json_standard(json, obj)
    case obj.class.superclass.name
    when 'ActiveRecord::Relation', 'ActiveRecord::AssociationRelation', 'ActiveRecord::Associations::CollectionProxy'
      json.array! obj do |o|
        json.partial! "standard/#{o.class.name.underscore}", obj: o
      end
    when 'ApplicationRecord'
      json.partial! "standard/#{obj.class.name.underscore}", obj: obj
    end
  end

  # 智能渲染
  def render_json_intelligence(json, obj, accepts = [], excepts = [], extras = [], partials = [])
    case obj.class.superclass.name
    when 'ActiveRecord::Relation'
      json.array! obj do |o|
        render_json_custom(json, o, accepts, excepts, extras)
      end
    when 'ActiveRecord::AssociationRelation'
      json.array! obj do |o|
        render_json_custom(json, o, accepts, excepts, extras)
      end
    when 'ActiveRecord::Associations::CollectionProxy'
      obj.each do |o|
        render_json_custom(json, o, accepts, excepts, extras)
      end
    when 'ApplicationRecord'
      return {} if obj.blank?

      render_json_custom(json, obj, accepts, excepts, extras, partials)
    else
      {}
    end
  end

  def render_json_custom(json, obj, accepts, excepts, extras = [], partials = [])
    accepts = obj.class.columns.map(&:name).map(&:to_sym) if accepts.blank?
    accepts -= excepts if excepts.present?

    accepts.each do |column|
      value = obj.__send__(column)

      value =
        case value
        when String
          case obj.class.column_for_attribute(column).type
          when :decimal
            value.to_f
          else
            value
          end
        when Array
          value
        when Float
          value.round(4)
        when ActiveSupport::TimeWithZone
          value.strftime('%F %T')
        else
          value
        end

      json.__send__(column, value)
    end

    if extras.present?
      extras.each do |extra|
        json.__send__(extra, obj.__send__(extra))
      end
    end

    if partials.present?
      partials.each do |partial|
        @result = obj.__send__(partial[:result])

        next if @result.blank?

        @extras = partial[:extras]
        @accepts = partial[:accepts]
        @excepts = partial[:excepts]
        @partials = partial[:partials]

        json.__send__(partial[:result], @result, partial: 'intelligence', as: partial[:result])
      end
    end
  end
end
