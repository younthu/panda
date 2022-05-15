# frozen_string_literal: true
  class Panda::Api::MessagesController < Panda::Api::BaseController
    expose(:result) { Panda::Message.find(params[:id]) }
    expose(:payload) { Panda::Message.params_permit(params) }

    def show
      result

      render :intelligence
    end

    def index
      @result = Panda::Message.recent.page(page).per(per)

      paginate @result

      render :intelligence
    end

    def create
      @result = Panda::Message.create! payload

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

