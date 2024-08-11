# frozen_string_literal: true

class Api::ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug { "Access denied on #{exception.action} #{exception.subject.inspect}" }
    render json: { message: 'Access Denied!' }, status: :forbidden
  end

  rescue_from Apipie::ParamError do |e|
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def pagy_render(collection, **vars)
    pagy, records = pagy(collection, **vars)
    pagy_headers_merge(pagy)
    render json: records
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
