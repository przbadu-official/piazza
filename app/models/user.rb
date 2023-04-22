# frozen_string_literal: true

class User < ApplicationRecord
  include Authentication

  # validations
  validates :name, presence: true
  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }

  # associations
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  # callbacks
  before_validation :strip_extraneous_spaces

  private

  def strip_extraneous_spaces
    self.name = name&.strip
    self.email = email&.strip
  end
end
