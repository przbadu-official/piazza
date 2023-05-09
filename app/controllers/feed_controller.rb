# frozen_string_literal: true

class FeedController < ApplicationController
  allow_unauthenticated

  def show
    @pagy, @listings = pagy(Listing.feed)
  end
end
