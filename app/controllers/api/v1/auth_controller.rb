# frozen_string_literal: true

module Api
  module V1
    class AuthController < ApplicationController
      before_action :authenticate_user!, only: [:me]

      def sign_in
        user = User.find_for_database_authentication(email: params[:email])
        if user&.valid_password?(params[:password])
          return render json: { error: "Account suspended" }, status: :forbidden if user.suspended?
          render json: auth_response(user)
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      def sign_up
        user = User.new(sign_up_params)
        if user.save
          render json: auth_response(user), status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def me
        render json: { user: user_json(@current_user) }
      end

      private

      def sign_up_params
        params.permit(:email, :password, :password_confirmation)
      end

      def auth_response(user)
        {
          token: JwtService.encode(user.id),
          user: user_json(user)
        }
      end

      def user_json(u)
        return nil if u.blank?

        {
          id: u.id,
          email: u.email,
          admin: u.admin?
        }
      end

      def authenticate_user!
        token = request.headers["Authorization"]&.split(" ")&.last
        user_id = JwtService.decode(token)
        return head :unauthorized if user_id.blank?

        user = User.find_by(id: user_id)
        return head :unauthorized if user.blank?
        return render json: { error: "Account suspended" }, status: :forbidden if user.suspended?

        @current_user = user
      end
    end
  end
end
