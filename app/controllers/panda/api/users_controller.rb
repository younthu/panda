module Panda
  module Api
    class UsersController < BaseController
      skip_before_action :authenticate_user!, only: [:create, :sms, :sms_login]

      def sms_login
        param! :mobile, String, required: true
        param! :code, String, required: true
        param! :invite_code, String, required: false

        SecurityCodeService.new(params[:mobile]).verify(params[:code])
        @result = Panda.User.find_or_create_by(mobile: params[:mobile])

        if params[:invite_code].present? # 新用户邀请
          raise CustomMessageError.new(422, '不能填写本人邀请码') if @result.invite_code == params[:invite_code]

          invest_user = Panda.User.where(invite_code: params[:invite_code]).first

          raise CustomMessageError.new(422, '邀请码错误') if invest_user.blank?

          raise CustomMessageError.new(422, '不能循环邀请') if invest_user.parent == @result

          @result.update(parent: invest_user)

        end

        extras
        render json: @result, methods: :auth_token
      end

      def sms
        param! :mobile, String, required: true

        SecurityCodeService.new(params[:mobile]).invoke

        head :created
      end

      def create
        user = Panda.User.create! params.permit(:name, :nickname, :email, :mobile, :password, :login, :firstname, :lastname, email_address: :address, email_address_attributes: :address)

        render json: user, methods: :auth_token
      end

      # DELETE, 删除当前账号. 因为删除的时候会抛很多关联关系删除不了的问题，所以做假删除，把用户的手机号码改掉，token改掉。
      def delete_account
        user = current_user
        user.update! mobile: "#{user.mobile}_deleted", secure_token: "#{ SecureRandom.base58(32) }",
                     password: SecureRandom.base58(22), email: "#{user.email}.deleted"

        head status: 204
      end

      # POST block_user?blocked_user_id=111
      # 拉黑某人
      def block_user
        param! :blocked_user_id, String, required: true
        u = current_user
        blocked_user = User.find params[:blocked_user_id]

        res = Blacklist.find_or_create_by(user: u, blocked_user: blocked_user)

        render json: res
      end

      # POST unblock_user?blocked_user_id=111
      # 把某人从黑名单里拉出来
      def unblock_user
        param! :blocked_user_id, String, required: true

        u = current_user
        blocked_user = User.find params[:blocked_user_id]

        Blacklist.where(user: u, blocked_user: blocked_user).destroy_all

        render json: {msg: :done}
      end

      # 黑名单
      def blacklist
        u = current_user
        @result = Blacklist.where(user:u)

        render json: @result, include: [user: {only: [:id, :name, :nickname, :gender, :avatar] }]
      end

      # post target_user_id, content, images
      # 举报用户
      def report_abuse
        param! :target_user_id, String, required: true
        user = current_user
        target_user = User.find params[:target_user_id]

        res = ReportAbuse.create! user: user, target_user: target_user, content: params[:content]

        render json: res
      end

      # TODO: Fixme
      def upload_avatar
        current_user.update({avatar: params[:avatar]})
        current_user.reload
        my_info
      end

      def my_info
        render json: current_user
      end

      def me
        @result = current_user

        render :intelligence
      end

      # 绑定苹果device token
      def bind_ios_device_token
        token = params[:token]

        if Panda::Device.where(user: current_user, token: token).count < 1
          Panda::Device.create!(user: current_user, token: token)
        end

        render json: {msg: "success"}
      end

      def update_my_info
        current_user.update params.require(:user).permit!

        render json: current_user
      end

      # 上传个人照片
      def append_photo
        u = current_user
        u.append_images params[:photos] if params[:photos]

        render json: current_user, include: [:photos]
      end

      # put 删除个人顶部滚动照片
      def delete_photos
        u = current_user
        u.remove_photos!
        u.save

        render json: u, include: [:photos]
      end

      def delete_photo
        u = current_user
        u.delete_photo(params[:file_name])
        u.save

        render json: u, include: [ :photos]
      end
    end
  end
end
