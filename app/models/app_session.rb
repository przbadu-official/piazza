# frozen_string_literal: true

class AppSession < ApplicationRecord
  # token will be auto generated in before_create callback and hence optional field.
  has_secure_password :token, validations: false

  # associations
  belongs_to :user

  # callbacks
  before_create do
    self.token = self.class.generate_unique_secure_token
  end
end
