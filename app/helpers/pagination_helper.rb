# frozen_string_literal: true

module PaginationHelper
  def show_paginator?
    !turbo_native_app? && instance_variable_get(:@pagy).pages > 1
  end
end
