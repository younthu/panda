# frozen_string_literal: true

  class WechatMiniService
    WECHAT_NOTIFY_URL = 'https://tekapic.ilibrary.me/api/v1/orders/wechat_mini_notify'

    def initialize
      WxPay.appid = 'wxb803d179ea68xxxx'
      WxPay.key = '37458xxxxx'
      WxPay.mch_id = '1599404xxx'
      WxPay.extra_rest_client_options = { timeout: 2, open_timeout: 3 }
      WxPay.set_apiclient_by_pkcs12(File.read("#{Rails.root}/lib/159940xxxx/apiclient_cert.p12"), '159940xxxx')
    end

    def pay(body, out_trade_no, price, wechat_open_id)
      body = {
        body: body,
        out_trade_no: out_trade_no,
        total_fee: (price.to_f * 100).to_i,
        spbill_create_ip: '127.0.0.1',
        notify_url: WECHAT_NOTIFY_URL,
        trade_type: 'JSAPI',
        openid: wechat_open_id
      }

      prepay_result = WxPay::Service.invoke_unifiedorder body

      params = {
        prepayid: prepay_result['prepay_id'],
        noncestr: prepay_result['nonce_str']
      }

      WxPay::Service.generate_js_pay_req params
    end

    # 付款到用户零钱账户, 这个是不收手续费的, amount单位为分，最低付款金额为100分.
    # 转一元钱到杨账户: Paymanager::WechatMiniService.new.transfer_to_user "oWe9O5aFM_0V_pzNLehXIX-t7tEE", 100, "杨xx"
    def transfer_to_user(openid, amount, check_name, name="", spbill_create_ip="")
      # openid = 'oWe9O5Rkf7zS5LMWpK62Md6VjHL4'
      # name = '陈x妮'
      # check_name = FORCE_CHECK || NO_CHECK, 如果没有实名好像不能实时到账.
      # 参数详见: https://pay.weixin.qq.com/wiki/doc/api/tools/mch_pay.php?chapter=14_2
      #
      # WxPay::Service.invoke_transfer return:
      #  {"return_code"=>"SUCCESS",
      #  "return_msg"=>"",
      #  "mch_appid"=>"wxb803d179ea68eda7",
      #  "mchid"=>"1599404521",
      #  "nonce_str"=>"683b5f72ec994854b56ae384950ec26a",
      #  "result_code"=>"SUCCESS",
      #  "partner_trade_no"=>"1624078997197",
      #  "payment_no"=>"10101212106112106193473071927497",
      #  "payment_time"=>"2021-06-19 13:03:18"}
      res = WxPay::Service.invoke_transfer({partner_trade_no: DateTime.now.strftime('%Q'), openid: openid, check_name: (check_name ? "FORCE_CHECK": "NO_CHECK"),
                                      amount: amount, desc: "xxx收入", re_user_name: name, spbill_create_ip: "127.0.0.1"})


      if not res["return_code"] == "SUCCESS"
        msg = res["return_msg"]
      end
      return res
    end
    def webhook(result)
      WxPay::Sign.verify?(result)
    end

    def withdraw(wechat_open_id, residue, desc)
      transfer = {
        partner_trade_no: SecureRandom.hex(16),
        openid: wechat_open_id,
        check_name: 'NO_CHECK',
        amount: (residue * 100).to_i,
        desc: desc,
        spbill_create_ip: '127.0.0.1'
      }

      WxPay::Service.invoke_transfer transfer
    end
  end
