# frozen_string_literal: true

require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  setup do
    @user = users(:jerry)
    @listing = listings(:auto_listing_1_jerry)
  end

  test 'down case tags before saving' do
    @listing.tags = %w[Electronics Tools]
    @listing.save!

    assert_equal %w[electronics tools], @listing.tags
  end
end
