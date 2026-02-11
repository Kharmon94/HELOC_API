# frozen_string_literal: true

Rails.application.config.redis = if ENV["REDIS_URL"].present?
  Redis.new(
    url: ENV["REDIS_URL"],
    timeout: 5,
    reconnect_attempts: 2
  )
else
  nil
end
