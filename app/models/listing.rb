# frozen_string_literal: true

class Listing < ApplicationRecord
  include PermittedAttributes
  include HasAddress
  include AccessPolicy

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
  validates :tags, length: { in: 1..5 }

  # Callbacks
  before_save :downcase_tags

  # Scopes
  scope :feed, -> { order(created_at: :desc).includes(:address) }

  private

  def downcase_tags
    self.tags = tags.map(&:downcase)
  end
end
