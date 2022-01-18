# frozen_string_literal: true
module Panda::Api
  class OrdersController < BaseController
    skip_before_action :authenticate_user!, only: %i[wechat_mini_notify]
    before_action :set_order, only: %i[show cancel_order confirm_order done_order reject_order comment]

    def index
      @user = current_user
      page = params[:page]

      if params[:status]
        @orders = @user.orders.recent.where(status: params[:status]).page(page).per(25)
      else
        @orders = @user.orders.recent.page(page).per(25)
      end


      # paginate @orders
      render json: @orders.uniq
    end

    def photographer_orders
      @user = current_user
      page = params[:page]

      if params[:status]
        @orders = @user.orders.recent.where(status: params[:status]).page(page).per(25)
      else
        @orders = @user.photographer_orders.recent.page(page).per(25)
      end


      # paginate @orders
      render json: @orders.uniq
    end

    def show; end

    def create
      param! :package_id, Integer

      package = Package.find_by id: params[:package_id]
      @user = current_user
      price = package.price
      package = Package.find(params[:package_id])
      @order = @user.orders.new(package: package, price: package.price, start_at: params[:start_at],
                                end_at: params[:end_at], title: package.title)

      @order.save

      # 订单绑定套餐
      PackageOrder.create!(order: @order, package: package)

      # 订单绑定花絮
      if params[:feature_ids]
        params[:feature_ids].each do |feature_id|
          f = Feature.find_by id: feature_id
          if f
            FeatureOrder.create!(feature: Feature.find_by(id: feature_id), order: @order)
            price += f.price
          end
        end
      end

      # 更新价格
      @order.update price: price

      result = Paymanager::WechatMiniService.new.pay(package.title, @order.code, @order.price, @user.openid)

      # 下单后给摄影师发一条邀约信息
      msg = Message.create!({sender: @user, receiver: package.user, msg_type: "order_initiated", payload: @order, body: "邀请拍摄套餐#{package.title}"})
      render json: result
    end

    def confirm_order
      @order.confirm!

      # 确认订单后删除老的订单确认消息，再发一条已确认信息
      Message.where(payload: @order).destroy_all
      msg = Message.create!({sender: current_user, receiver: @order.user, payload: @order, body: "拍摄预约已接受", msg_type: "order_confirmed"})

      # 确认订单后给摄影师生成一条income记录, waiting_for_pay 表示待平台支付给摄影师。
      income = Income.create!({incomesource: @order, user: current_user, status: :waiting_for_pay, amount: @order.price})
      render json: @order
    end

    def reject_order
      @order.reject!

      # 确认订单后删除老的订单确认消息，再发一条已确认信息
      Message.where(payload: @order).destroy_all
      msg = Message.create!({sender: current_user, receiver: @order.user, payload: @order, body: "拍摄预约已被拒绝", msg_type: "order_status_update"})

      render json: @order
    end

    def cancel_order
      @order.cancel!
      # 自动退款

      u = current_user
      sender = current_user # 假设是摄影师在取消订单，sender为摄影师，receiver为用户
      receiver = @order.user

      if receiver == sender # 发现sender实际上是用户，用户在取消订单，那么receiver改为摄影师
        receiver = @order.photographer
      end
      msg = Message.create!({sender: current_user, receiver: @order.user, payload: @order, body: "拍摄预约已被取消", msg_type: "order_status_update"})

      render json: @order
    end

    def comment
      body = params["body"]
      c = Comment.create!(resource: @order, author: current_user, body:  HarmoniousDictionary.clean(body), photos: params[:photos])
      c.create_censor!({status: :pass})
      @order.comment_order!

      render json: c, include: [:resource, :author], methods: :status
    end

    def done_order
      @order.finish!

      render json: @order
    end

    def has_new_order
      has_unread_order = current_user.photographer_orders.unread_by(current_user).count > 0
      render json: {has_unread_order: has_unread_order}
    end

    def mark_all_orders_as_read
      current_user.photographer_orders.unread_by(current_user).each do |order|
        order.mark_as_read! for: current_user
      end

      render json: {status: :done}
    end

    def wechat_mini_notify
      result = Hash.from_xml(request.body.read)['xml']
      success = Paymanager::WechatMiniService.new.webhook(result)
      if success
        order = Order.where(code: result['out_trade_no']).first

        if order.blank?
          render json: { message: '无此订单' }
          return
        else
          order.pay!
        end

        render xml: { return_code: 'SUCCESS' }.to_xml(root: 'xml', dasherize: false)
      else
        render xml: { return_code: 'FAIL', return_msg: '签名失败' }.to_xml(root: 'xml', dasherize: false)
      end
    rescue StandardError => e
      render json: { message: '非法问题订单' }
    end


    private

    def set_order
      @order = Order.find(params[:id])
    end
  end
end
