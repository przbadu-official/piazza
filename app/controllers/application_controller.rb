# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authenticate
  include SetCurrentRequestDetails

  helper_method :turbo_frame_request?
  helper_method :turbo_native_app?
end
