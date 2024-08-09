# frozen_string_literal: true

class Api::V1::BorrowsController < ApplicationController
  load_and_authorize_resource

  # GET /borrows
  def index
    render json: @borrows, status: :ok
  end

  # GET /borrows/1
  def show
    render json: @borrow, status: :ok
  end

  # POST /borrows
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

  # PATCH/PUT /borrows/1
  def update
    if @borrow.update(update_params)
      render json: @borrow, status: :ok
    else
      render json: @borrow.errors, status: :unprocessable_entity
    end
  end

  # DELETE /borrows/1
  def destroy
    @borrow.destroy!
  end

  private

  def set_borrow
    @borrow = Borrow.find(params[:id])
  end

  def create_params
    params.require(:borrow).permit(:book_id, :user_id)
  end

  def update_params
    params.require(:borrow).permit(:book_id, :user_id, :returned)
  end
end
