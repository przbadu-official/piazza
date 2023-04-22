# frozen_string_literal: true

class Organization < ApplicationRecord
  # associations
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user
end
