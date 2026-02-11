# frozen_string_literal: true

module Api
  module V1
    class PartnersController < ApplicationController
      def index
        partners = Partner.active.ordered
        render json: { partners: partners.map { |p| partner_json(p) } }
      end

      private

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
          match_score: p.match_score
        }
      end
    end
  end
end
