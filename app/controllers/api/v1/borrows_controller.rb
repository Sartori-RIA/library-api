# frozen_string_literal: true

class Api::V1::BorrowsController < ApplicationController
  load_and_authorize_resource

  def_param_group :borrow do
    param :borrow, Hash, action_aware: true do
      param :status, String
      param :end_date, String
      param :user_id, Integer
      param :book_id, Integer
    end
  end

  api :GET, 'v1/users', 'Retrieves Books from DB'
  format 'json'
  error code: 401, desc: 'You need to Sign-In first'
  error code: 403, desc: 'You\'re not allow to access here'
  error code: 404, desc: 'Not Found'
  error code: 422, desc: 'Unprocessable Entity'
  param :page, Hash do
    param :number, Integer, required: false, desc: 'Page Number'
    param :size, Integer, required: false, desc: 'Page Size, default 20'
  end
  returns array_of: :borrow
  def index
    pagy_render(@borrows)
  end

  api :GET, '/v1/borrows/:id', 'Retrieves Borrow from DB by ID'
  format 'json'
  param :id, Integer, desc: 'Borrow ID', required: true
  error code: 401, desc: 'You need to Sign-In first'
  error code: 403, desc: 'You\'re not allow to access here'
  error code: 404, desc: 'Not Found'
  error code: 422, desc: 'Unprocessable Entity'
  returns :borrow
  def show
    render json: @borrow, status: :ok
  end

  api :POST, '/v1/borrows', 'Add a Borrow on DB'
  format 'json'
  param_group :borrow, as: :create
  error code: 401, desc: 'You need to Sign-In first'
  error code: 403, desc: 'You\'re not allow to access here'
  error code: 404, desc: 'Not Found'
  error code: 400, desc: 'Bad Request, you\'re forgetting something'
  error code: 422, desc: 'Unprocessable Entity'
  returns :borrow
  def create
    Borrow.transaction do
      @borrow = Borrow.new(create_params)

      if @borrow.save
        render json: @borrow, status: :created
      else
        render json: @borrow.errors, status: :unprocessable_entity
      end
    end
  end

  api :PATCH, '/v1/borrows/:id', 'Updates Borrow on DB'
  format 'json'
  param :id, Integer, desc: 'Borrow ID', required: true
  param_group :borrow, as: :update
  error code: 400, desc: 'Bad Request, you\'re forgetting something'
  error code: 401, desc: 'You need to Sign-In first'
  error code: 403, desc: 'You\'re not allow to access here'
  error code: 404, desc: 'Not Found'
  error code: 400, desc: 'Bad Request, you\'re forgetting something'
  error code: 422, desc: 'Unprocessable Entity'
  returns :borrow
  def update
    if @borrow.update(update_params)
      render json: @borrow, status: :ok
    else
      render json: @borrow.errors, status: :unprocessable_entity
    end
  end

  private

  def set_borrow
    @borrow = Borrow.find(params[:id])
  end

  def create_params
    params.require(:borrow).permit(:book_id, :user_id)
  end

  def update_params
    params.require(:borrow).permit(:status)
  end
end
