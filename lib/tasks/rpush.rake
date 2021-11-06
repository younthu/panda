namespace :rpush do
    desc 'send push notification, rails rpush:push_to_device["你好"]'
    task :push_to_device, [:message, :device_token]=> [:environment] do |task, args|
        n = Rpush::Apns2::Notification.new;
        n.app = Rpush::Apns2::App.find_by_name("blind_glass_ios_app");
        n.device_token= args[:device_token] ||"3BCF630D0F096B79FC3EB80BD0232FCCA5368A92006BBF7DCA2D847EEDE5B8E8";
        n.alert = args[:message] || "hi mom!"
        n.data = {
            headers: { 'apns-topic': "com.zhiyin.glass" },
            foo: :bar
        }
        n.save!
    end

    desc 'send push notification via p8, rails rpush:p8push_to_device["你好"]'
    task :p8push_to_device, [:message, :device_token]=> [:environment] do |task, args|
        n = Rpush::Apnsp8::Notification.new;
        n.app = Rpush::Apnsp8::App.find_by_name("blind_glass_ios_app_p8");
        n.device_token= args[:device_token] ||"3BCF630D0F096B79FC3EB80BD0232FCCA5368A92006BBF7DCA2D847EEDE5B8E8";
        n.alert = args[:message] || "hi dad!"
        n.data = {
          headers: { 'apns-topic': "com.zhiyin.glass" },
          foo: :bar
        }
        n.save!
    end

end
