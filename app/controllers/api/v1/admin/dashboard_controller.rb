# frozen_string_literal: true

module Api
  module V1
    module Admin
      class DashboardController < BaseController
        include Authorization
        before_action :require_admin!

        def index
          render json: { message: "Admin dashboard", user_id: current_user.id }
        end
      end
    end
  end
end
