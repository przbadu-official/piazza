# frozen_string_literal: true

class Listing < ApplicationRecord
  # Enum
  enum :condition, {
    mint: 'mint',
    near_mint: 'near_mint',
    used: 'used',
    defective: 'defective'
  }

  # Associations
  belongs_to :organization
  belongs_to :creator, class_name: 'User'

  # Validations
  validates :title, length: { in: 10..100 }
  validates :price, numericality: { only_integer: true }
  validates :condition, presence: true
end
