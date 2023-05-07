# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include HumanEnum
  include MessageVerifier

  primary_abstract_class
end
