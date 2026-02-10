# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from CanCanCan::AccessDenied do |e|
    render json: { error: "Access denied", message: e.message }, status: :forbidden
  end

  def current_user
    nil
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
