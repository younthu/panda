# frozen_string_literal: true

class Panda::Api::LoginByCodesController < ::ApplicationController
  skip_before_action :verify_authenticity_token

  include ActionView::Rendering
  def render_to_body(options)
    _render_to_body_with_renderer(options) || super
  end

  # 绑定微信到手机用户
  def bindWechat
    @user = current_user

    code = params[:code]
    res = Wechat.api.jscode2session(code)
    openid = res['openid']
    session_key = res['session_key']

    @user.openid = openid
    @user.session_key = session_key
    @user.skip_password_validation = true
    # login_user.confirmed_at = Time.zone.now if login_user.new_record?
    @user.save!

    update_user_info

    @auth_token = @user.auth_token

    render json: @user, methods: [:auth_token] and return
  end

  def create
    code = params[:code]
    res = Wechat.api.jscode2session(code)
    openid = res['openid']
    session_key = res['session_key']
    # openid = "oiWo445A9vVeZ49dmdz5VhrccAjg"
    # session_key = "bHX0jIrSer0T5g0cYXpFoQ=="

    login_user = User.find_or_initialize_by(openid: openid)
    login_user.email = "#{openid}@wechat.com" unless login_user.email.present?
    # 新建记录需要补充字段, name, mobile, uid
    if not login_user.persisted?
      login_user.name = "名字" #res['nickname']
      login_user.mobile = openid # TODO: 把微信认证移到identity和profile里面去，不要直接放user里面了。
      login_user.uid = openid
    end
    login_user.session_key = session_key
    login_user.skip_password_validation = true
    # login_user.confirmed_at = Time.zone.now if login_user.new_record?
    login_user.save!

    @user = login_user
    update_user_info

    sign_in login_user

    user_encoder = Warden::JWTAuth::UserEncoder.new
    payload = user_encoder.helper.payload_for_user(login_user, "user")
    payload["exp"] = Time.now.to_i + 1.year
    payload["aud"] = 'yoga'
    jwt = Warden::JWTAuth::TokenEncoder.new.call(payload)
    login_user.allowlisted_jwts.create(jti: payload["jti"], aud: payload["aud"], exp: Time.at(payload["exp"]))

    # render json: { openid: openid, jwt: jwt }, status: :ok
    @auth_token = @user.auth_token

    render json: login_user, methods: [:auth_token] and return
    # render "show.json" and return
  end

  private

  def update_user_info
    # @user = current_user
    r = Wechat.decrypt(params[:encryptedData], @user.session_key, params[:iv])
    if r["errcode"]
      Rails.logger.error "Failed to decrypt user info"
      Rails.logger.error r

    else
      @user.skip_password_validation = true
      # @user.update(name:r["nickName"] || @user.nick_name,nick_name: r["nickName"] || @user.nick_name,
      #              gender: (r["gender"]=="1" or r["gender"]==1) ? "男": "女",
      #              language: r["language"], city: r["city"], province: r["province"], country: r["country"],
      #              avatar_url: r["avatarUrl"])

      # FIXME: 尽可能多的把微信用户信息保留下来
      @user.update(name:r["nickName"] || @user.name)
    end

  end

  def user_info_params
    params.require(:detail).permit(:errMsg, :rawData,
                                   :signature, :encryptedData, :iv,
                                   userInfo: [:nickName, :gender, :language, :city, :province, :country, :avatarUrl])
  end

end
