# frozen_string_literal: true

redis_params = {
  host: Settings.redis.host,
  port: Settings.redis.port,
  id: nil
}
redis_params.merge(password: Settings.redis.password) if Settings.redis.password

sidekiq_redis_params = {
  url: "redis://#{Settings.redis.host}:#{Settings.redis.port}/#{Settings.redis.sidekiq_db}",
  namespace: Settings.redis.namespace
}
sidekiq_redis_params.merge(password: Settings.redis.password) if Settings.redis.password

$redis = Redis::Namespace.new(
  Settings.redis.namespace,
  redis: Redis.new(redis_params.merge(db: Settings.redis.queue))
)

Sidekiq.configure_server do |config|
  config.redis = sidekiq_redis_params

  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path('../scheduler.yml', __dir__))
    Sidekiq::Scheduler.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_redis_params
end
