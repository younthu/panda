1. 发送小程序通知:
  在控制台运行下面的代码.
  ~~~ruby
  # 预约成功提醒
	h = { touser: 'oM65e5SSBCNX7lkV3jrCesXUiGZU', template_id: 'vsMpFQHTmV7zuKdTRFuVysNIvgo0nqOqdKiVAyEYovM', page: 'pages/index/index',
		data: {thing6: {value: '课程马上开始'}, thing1: {value: '消息'}, time2:{value: DateTime.now.strftime("%Y年%m月%d日 %H:%M")},
				thing3: {value: '请准时参加'}, thing4: {value: '外滩店'}, name5: {value: '笑哈哈'}}}

	Wechat.api.subscribe_message_send(h)
	# 一次性消息模板发送一次以后就不能再发了，等让用户重新接受一次消息推送
  ~~~

  ~~~ruby
   # 打卡成功通知
   h2 = {touser: 'oM65e5SSBCNX7lkV3jrCesXUiGZU', template_id: 'NmezPh5g6hN6F78YPfTHVEEbgmGspEqdtgvBPNs4DOg', page: 'pages/index/index', data: {number3: {value: 10}, date2: {value: DateTime.now.strftime("%Y年%m月%d日 %H:%M")}, thing1: {value: '瑜伽'}, thing4: {value: '外堂'}}

   Wechat.api.subscribe_message_send(h)
  ~~~
