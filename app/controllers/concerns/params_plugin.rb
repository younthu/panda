# frozen_string_literal: true

module ParamsPlugin
  extend ActiveSupport::Concern
  def page
    params[:page].to_i || 1
  end

  def start_at
    params[:start_at].present? ? Time.zone.parse(params[:start_at]) : nil
  end

  def end_at
    params[:end_at].present? ? Time.zone.parse(params[:end_at]) + 1.day : Time.zone.now
  end

  def per
    params[:per].to_i.zero? ? 10 : params[:per].to_i
  end

  def paginate(data)
    @pagination =
      if data.try(:current_page).present?
        {
          current_page: data.current_page,
          total_pages: data.total_pages,
          next_page: data.next_page,
          total_count: data.total_count,
          per: per
        }
      end
  end
end
