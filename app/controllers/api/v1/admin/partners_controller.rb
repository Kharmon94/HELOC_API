# frozen_string_literal: true

module Api
  module V1
    module Admin
      class PartnersController < BaseController
        include Authorization
        before_action :require_admin!

        def index
          partners = Partner.ordered
          render json: { partners: partners.map { |p| partner_json(p) } }
        end

        def create
          @partner = Partner.new(partner_params)
          @partner.position = (Partner.maximum(:position) || 0) + 1 if @partner.position.to_i.zero?
          if @partner.save
            render json: { partner: partner_json(@partner) }, status: :created
          else
            render json: { errors: @partner.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def update
          @partner = Partner.find(params[:id])
          if @partner.update(partner_params)
            render json: { partner: partner_json(@partner) }
          else
            render json: { errors: @partner.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def destroy
          @partner = Partner.find(params[:id])
          @partner.update!(active: false)
          head :no_content
        end

        private

        def partner_params
          params.require(:partner).permit(
            :name, :rating, :min_loan, :max_loan, :apr_from, :url,
            :best_for, :why_matched, :match_score, :position, :active,
            features: [], credit_tier: [], specialties: []
          )
        end

        def partner_json(p)
          return nil if p.blank?

          {
            id: p.id,
            name: p.name,
            rating: p.rating&.to_f,
            min_loan: p.min_loan,
            max_loan: p.max_loan,
            apr_from: p.apr_from,
            url: p.url,
            best_for: p.best_for,
            features: p.features.is_a?(Array) ? p.features : [],
            why_matched: p.why_matched,
            credit_tier: p.credit_tier.is_a?(Array) ? p.credit_tier : [],
            specialties: p.specialties.is_a?(Array) ? p.specialties : [],
            match_score: p.match_score,
            position: p.position,
            active: p.active,
            created_at: p.created_at&.iso8601
          }
        end
      end
    end
  end
end
