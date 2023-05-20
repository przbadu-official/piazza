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
  has_one_attached :photo
  has_rich_text :description

  # Validations
  validates :title, length: { in: 10..100 }
  validates :price, numericality: { only_integer: true }
  validates :condition, presence: true
  validates :tags, length: { in: 1..5 }
  validates :photo, presence: true
  validates :description, presence: true

  # Callbacks
  before_save :downcase_tags

  # Scopes
  scope :feed, lambda {
    order(created_at: :desc)
      .includes(:address)
      .with_attached_cover_photo
  }

  private

  def downcase_tags
    self.tags = tags.map(&:downcase)
  end
end
