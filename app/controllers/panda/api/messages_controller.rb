# frozen_string_literal: true
  class Panda::Api::MessagesController < Panda::Api::BaseController
    expose(:klass) { Panda::Message }
    expose(:extras) { [] }

    # 我的聊天, 包含我收到的和我发送的，如果参数里有session_id, 则只显示这个session的
    def index
      if(params[:session_id])
        @result = Panda::Message.messages_for(current_user).in_session(params[:session_id]).recent.page(page).per(per)
      else
        @result = Panda::Message.messages_for(current_user).recent.page(page).per(per)
      end

      paginate @result

      render :intelligence
    end

    def create
      param! :receiver_id, Integer, required: true
      @result = Panda::Message.create! payload.merge!(sender: current_user, receiver: Panda::User.find(params[:receiver_id]))

      render :intelligence
    end
  end

