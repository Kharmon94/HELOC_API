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
        if @user.update(user_params)
          render json: { user: user_json(@user) }
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email)
      end

      def user_json(u)
        return nil if u.blank?

        { id: u.id, email: u.email, admin: u.admin? }
      end
    end
  end
end
