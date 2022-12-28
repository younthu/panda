常用的配置
1. 配置redis
   ~~~ruby
    # https://guides.rubyonrails.org/caching_with_rails.html#activesupport-cache-rediscachestore
    cache_servers = ["redis://:#{Settings.redis&.password}@#{Settings.redis&.host}:#{Settings.redis&.port}/0"]
    config.cache_store = :redis_cache_store, { url: cache_servers,

                                               connect_timeout:    30,  # Defaults to 20 seconds
                                               read_timeout:       0.2, # Defaults to 1 second
                                               write_timeout:      0.2, # Defaults to 1 second
                                               reconnect_attempts: 1,   # Defaults to 0

                                               error_handler: -> (method:, returning:, exception:) {
                                                 # Report errors to Sentry as warnings
                                                 Raven.capture_exception exception, level: 'warning',
                                                                         tags: { method: method, returning: returning }
                                               }
    }
   ~~~
   
或者
   ~~~ruby
   # cache_store
   config.cache_store = :redis_cache_store, {
           host: Settings.redis.host,
           password: Settings.redis.password,
           port: Settings.redis.port,
           db: Settings.redis.db,
           expires_in: Settings.redis.expires_in,
           namespace: Settings.redis.namespace
   }
   ~~~
2. 在目标app里面加载overrides
   ~~~ruby
   # config/application.rb
   overrides = "#{Rails.root}/app/overrides"
    Rails.autoloaders.main.ignore(overrides)

    config.to_prepare do
      Dir.glob("#{overrides}/**/*_override.rb").each do |override|
        load override
      end
    end
   ~~~
3. 