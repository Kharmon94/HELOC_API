# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_user!
      attr_reader :current_user

      private

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
