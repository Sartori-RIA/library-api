# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # def create
  #   @user = User.new sign_up_params
  #   @user.save
  #   return render json: { user: @user.errors }, status: :unprocessable_entity if @user.errors.present?
  #
  #   if params[:organization_attributes].blank?
  #     sign_in @user, store: false
  #   elsif build_organization
  #     @user.update(organization_id: @organization.id)
  #     sign_in @user, store: false
  #   else
  #     @user.really_destroy!
  #     render json: { organization_attributes: @organization.errors }, status: :unprocessable_entity
  #   end
  # end
end
