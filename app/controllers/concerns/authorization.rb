# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  def require_admin!
    return if current_user&.admin?

    render json: { error: "Access denied", message: "Admin required" }, status: :forbidden
  end
end
