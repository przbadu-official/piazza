# frozen_string_literal: true

module Address::PermittedAttributes
  extend ActiveSupport::Concern

  class_methods do
    def permitted_attributes
      %w[id line1 line2 city postcode country]
    end
  end
end
