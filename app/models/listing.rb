# frozen_string_literal: true

class Listing < ApplicationRecord
  # Associations
  belongs_to :organization
  belongs_to :creator, class_name: 'User'

  # Validations
  validates :title, length: { in: 10..100 }
  validates :price, numericality: { only_integer: true }
end
