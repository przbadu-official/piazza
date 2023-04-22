# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'requires a name' do
    @user = User.new(name: '', email: 'john@doe.com', password: 'password', password_confirmation: 'password')
    assert_not @user.valid?

    @user.name = 'John'
    assert @user.valid?
  end

  test 'requires a valid email' do
    @user = User.new(name: 'John', email: '', password: 'password', password_confirmation: 'password')
    assert_not @user.valid?

    @user.email = 'invalid'
    assert_not @user.valid?

    @user.email = 'john@doe.com'
    assert @user.valid?
  end

  test 'requires a unique email' do
    @existing_user = User.create!(name: 'John', email: 'jd@example.com', password: 'password', password_confirmation: 'password')
    assert @existing_user.persisted?

    @user = User.new(name: 'Jon', email: 'jd@example.com')
    assert_not @user.valid?
  end

  test 'name and email is stripped of spaces before saving' do
    @user = User.create!(
      name: ' John ',
      email: ' john@doe.com ',
      password: 'password',
      password_confirmation: 'password'
    )
    assert_equal 'John', @user.name
    assert_equal 'john@doe.com', @user.email
  end

  test "password length must be between 8 and ActiveModel's maximum" do
    @user = User.new(
      name: 'Jane',
      email: 'jane@doe.com',
      password: '',
      password_confirmation: 'password'
    )
    assert_not @user.valid?

    @user.password = 'password'
    assert @user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    @user.password = 'a' * (max_length + 1)
    assert_not @user.valid?
  end

  test 'can create a session with email and correct password' do
    @app_session = User.create_app_session(
      email: 'jerry@example.com',
      password: 'password'
    )

    assert_not_nil @app_session
    assert_not_nil @app_session.token
  end

  test 'cannot create a session with email and incorrect password' do
    @app_session = User.create_app_session(
      email: 'jerry@example.com',
      password: 'WRONG'
    )

    assert_nil @app_session
  end

  test 'creating a session with non existent email returns nil' do
    @app_session = User.create_app_session(
      email: 'whoami@example.com',
      password: 'WRONG'
    )

    assert_nil @app_session
  end
end
