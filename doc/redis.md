1. add following gem:
   ~~~
   # Use Redis adapter to run Action Cable in production
	gem 'redis' # 这个gem提供:redis_cache_store
	gem 'redis-namespace'
	gem 'redis-rails'
   ~~~
1. 怎么配置'redis'见这里[官方文档](https://guides.rubyonrails.org/caching_with_rails.html#activesupport-cache-rediscachestore).
1. add following line to development.rb:
   ~~~ruby
    cache_servers = %w(redis://cache-01:6379/0 redis://cache-02:6379/0)
	config.cache_store = :redis_cache_store, { url: cache_servers,
		connect_timeout:    30,  # Defaults to 20 seconds
		read_timeout:       0.2, # Defaults to 1 second
		write_timeout:      0.2, # Defaults to 1 second
		reconnect_attempts: 1,   # Defaults to 0
        expires_in: 90.minutes, # 可以不用填，在cache.write的时候指定expires_in, Rails.cache.write "test2", 2, expires_in: 1.minute

		error_handler: -> (method:, returning:, exception:) {
		# Report errors to Sentry as warnings
		Raven.capture_exception exception, level: 'warning',
		tags: { method: method, returning: returning }
		}
	}
   ~~~

1. 安装Gem: `bundle install`
1. 进入rails console: `rails console`
   ~~~ruby
   # https://apidock.com/rails/ActiveSupport/Cache/Store/fetch
   Rails.cache.write "test", 1
   Rails.cache.write "test2", 2, expires_in: 1.minute
   Rails.cache.fetch 'test'
   ~~~
1. 进入redis-cli: `keys test*`
