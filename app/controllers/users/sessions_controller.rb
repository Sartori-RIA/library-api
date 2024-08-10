# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

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
