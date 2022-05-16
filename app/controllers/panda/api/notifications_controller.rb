# frozen_string_literal: true
  class Panda::Api::NotificationsController < ApplicationController
    expose(:result) { Panda::Notification.find(params[:id]) }
    expose(:payload) { Panda::Notification.params_permit(params) }

    def show
      result

      render :intelligence
    end

    def index
      @result = Panda::Notification.recent.page(page).per(per)

      paginate @result

      render :intelligence
    end

    def create
      @result = Panda::Notification.create! payload

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

