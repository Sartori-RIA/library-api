# frozen_string_literal: true

class Api::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, only: [:create]
  respond_to :json

  def create
    user = User.new(sign_up_params)
    if user.save
      sign_in(user, store: false)
      render json: { message: 'Registration successful' }, status: :ok
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
