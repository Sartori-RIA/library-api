# frozen_string_literal: true

class Api::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:create]
  respond_to :json

  def create
    user = User.find_for_database_authentication(email: params.dig(:user, :email))
    if user&.valid_password?(params.dig(:user, :password))
      sign_in(user, store: false)
      render json: { message: 'Login successful' }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  protected

  def respond_with(resource, _opts = {})
    @user = resource
  end

  def respond_to_on_destroy
    head :ok
  end

  def sign_in_params
    params.permit(:email, :password)
  end
end
