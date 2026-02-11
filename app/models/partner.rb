# frozen_string_literal: true

class Partner < ApplicationRecord
  serialize :features, coder: JSON
  serialize :credit_tier, coder: JSON
  serialize :specialties, coder: JSON

  validates :name, presence: true

  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(position: :asc, name: :asc) }
end
