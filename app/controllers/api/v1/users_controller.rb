# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      load_and_authorize_resource

      def index
        render json: { users: @users.map { |u| user_json(u) } }
      end

      def show
        render json: { user: user_json(@user) }
      end

      def update
        if current_user.admin? && @user.id == current_user.id && disallowed_self_update?
          return render json: { error: "Cannot change your own admin or suspended status" }, status: :forbidden
        end
        if @user.update(user_params)
          render json: { user: user_json(@user) }
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def disallowed_self_update?
        u = params[:user]
        u.is_a?(ActionController::Parameters) && (u.key?(:admin) || u.key?(:suspended))
      end

      def user_params
        permitted = [ :email ]
        permitted += [ :suspended, :admin ] if current_user.admin?
        params.require(:user).permit(permitted)
      end

      def user_json(u)
        return nil if u.blank?

        payload = { id: u.id, email: u.email, admin: u.admin? }
        if current_user.admin?
          payload[:suspended] = u.suspended?
          payload[:created_at] = u.created_at&.iso8601
        end
        payload
      end
    end
  end
end
