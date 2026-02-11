# frozen_string_literal: true

class HealthController < ActionController::API
  def show
    if db_ok? && redis_ok?
      head :ok
    else
      head :service_unavailable
    end
  end

  private

  def db_ok?
    ActiveRecord::Base.connection.execute("SELECT 1")
    true
  rescue StandardError
    false
  end

  def redis_ok?
    redis = Rails.application.config.redis
    return true if redis.nil?

    redis.ping
    true
  rescue StandardError
    false
  end
end
