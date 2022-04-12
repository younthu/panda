   1. start rpush(optional): `rpush start`
	1. Both two commands below work in mac, but, not in linux.
	1. send notification to a device: `rails rpush:p8push_to_device["你好","BF1F297A3B62D1517BB19D5D67BD0BC72D438F94F016DAD6E2B175AE01BFC38D"]`
	1. send notification to device: `rails rpush:push_to_device["你好","BF1F297A3B62D1517BB19D5D67BD0BC72D438F94F016DAD6E2B175AE01BFC38D"]`
	2. `BF1F297A3B62D1517BB19D5D67BD0BC72D438F94F016DAD6E2B175AE01BFC38D` 是device token.


1. 具体实现请参考`lib/rpush.rake`, 里面的代码来自于`https://github.com/younthu/blind-glass-server/blob/master/lib/tasks/send_notification.rake`

