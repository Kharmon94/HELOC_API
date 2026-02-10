# frozen_string_literal: true

class JwtService
  SECRET = Rails.application.secret_key_base
  EXPIRY = 24.hours

  class << self
    def encode(user_id)
      payload = { user_id: user_id, exp: EXPIRY.from_now.to_i }
      JWT.encode(payload, SECRET)
    end

    def decode(token)
      return nil if token.blank?
      payload = JWT.decode(token, SECRET).first
      payload["user_id"]
    rescue JWT::DecodeError
      nil
    end
  end
end
