# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  # validations
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  validates :name, presence: true
  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }

  # relationships
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
