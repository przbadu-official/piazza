# frozen_string_literal: true

module User::Authentication
  extend ActiveSupport::Concern

  included do
    has_secure_password

    # validations
    validates :password,
              on: %i[create password_change],
              presence: true,
              confirmation: true,
              length: { minimum: 8 }
    validates :password_confirmation, presence: true, on: :create

    # associations
    has_many :app_sessions, dependent: :destroy
  end

  class_methods do
    def create_app_session(email:, password:)
      user = User.find_by(email: email.downcase)
      return nil if user.blank?

      user.app_sessions.create! if user.authenticate(password)
    end
  end

  def authenticate_app_session(app_session_id, token)
    app_sessions.find(app_session_id).authenticate_token(token)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
