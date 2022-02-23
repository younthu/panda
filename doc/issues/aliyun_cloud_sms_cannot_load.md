/Users/i532140/.rvm/gems/ruby-3.0.3/gems/zeitwerk-2.5.1/lib/zeitwerk/kernel.rb:35:in `require': cannot load such file -- aliyun-cloud_sms (LoadError)

原因:
1. require目录下没有同名的aliyun-cloud_sms.rb, 解释见https://guides.rubygems.org/faqs/

解决办法:
1. ruby -e 'require "aliyun/cloud_sms"' # aliyun/cloud_sms.rb为aliyun-cloud_sms/lib下的文件
1. require path定义: aliyun_cloud_sms.gemspec下`spec.require_paths = ["lib"]`
1. 查看其它gem的lib就会发现, 都有同名的rb文件, 这是为何require能找到的原因.

ref:
https://guides.rubygems.org/faqs/
