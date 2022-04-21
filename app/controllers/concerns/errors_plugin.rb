# frozen_string_literal: true

module ErrorsPlugin
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :server_error
    rescue_from CustomMessageError, with: :error_4xx
    rescue_from ActionController::ParameterMissing, with: :error_422
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from ActionController::ParameterMissing, with: :error_422
    rescue_from RailsParam::InvalidParameterError, with: :error_422
  end

  private

  def server_error(exception)
    ExceptionNotifier.notify_exception(exception, env: request.env, data: { message: exception.message })

    Rails.logger.error exception.message
    Rails.logger.error exception.backtrace.join("\n").to_s

    render json: { message: exception.message }.to_json, status: :http_version_not_supported
  end

  def error_validate(e)
    render json: { message: e.summary.split(':')[1] }.to_json, status: :misdirected_request
  end

  def render_unprocessable_entity_response(exception)
    message = exception.record.errors.full_messages.join("\n")
    render json: { message: message }, status: :unprocessable_entity
  end

  def error_4xx(e)
    render json: { message: e.message }.to_json, status: e.status
  end

  def error_404(e)
    render json: { message: e.message }.to_json, status: :not_found
  end

  def error_422(e)
    render json: { message: e.message }.to_json, status: :unprocessable_entity
  end
end
