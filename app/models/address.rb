# frozen_string_literal: true

class Address < ApplicationRecord
  include PermittedAttributes

  attribute :country, default: 'GB'

  # Associations
  belongs_to :addressable, polymorphic: true

  # Validations
  validates :line1, presence: true
  validates :line2, presence: true
  validates :city, presence: true
  validates :postcode, presence: true
  validates :country, presence: true

  def redacted
    "#{city}, #{postcode}"
  end
end
