# frozen_string_literal: true

class CreatePartners < ActiveRecord::Migration[8.0]
  def change
    create_table :partners do |t|
      t.string :name, null: false
      t.decimal :rating, precision: 3, scale: 2
      t.string :min_loan
      t.string :max_loan
      t.string :apr_from
      t.string :url
      t.string :best_for
      t.text :features
      t.string :why_matched
      t.text :credit_tier
      t.text :specialties
      t.integer :match_score
      t.integer :position, default: 0, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :partners, :name
    add_index :partners, :position
    add_index :partners, :active
  end
end
