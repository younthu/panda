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

    desc 'seed app for push notification'
    task :seed, [:app] => [:environment] do |task, args|
        # 创建push 服务, Apns2
        app = Rpush::Apns2::App.new;
        app.name = "blind_glass_ios_app";
        app.certificate = File.read("./certs/aps_dev.pem");
        app.environment = "development";
        app.password = "";
        app.bundle_id = "com.zhiyin.glass";
        app.connections = 1;
        app.save!;

        # Apns p8
        app = Rpush::Apnsp8::App.new
        app.name = "blind_glass_ios_app_p8"
        app.apn_key = File.read("./certs/AuthKey_5DMW53GX22.p8")
        app.environment = "development" # APNs environment.
        app.apn_key_id = "5DMW53GX22" # This is the Encryption Key ID provided by apple
        app.team_id = "HXEHGC77U2" # the team id - e.g. ABCDE12345
        app.bundle_id = "com.zhiyin.glass" # the unique bundle id of the app, like com.example.appname
        app.connections = 1
        app.save!
    end

end
