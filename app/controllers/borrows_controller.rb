# frozen_string_literal: true

class BorrowsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def new; end

  def edit; end

  def create
    @borrow = Borrow.new(borrow_params)

    if @borrow.save
      redirect_to @borrow, notice: t('flash.models.borrow.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @borrow.update(borrow_params)
      redirect_to @borrow, notice: t('flash.models.borrow.updated'), status: :ok
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @borrow.destroy!
    redirect_to borrows_url, notice: t('flash.models.borrow.deleted'), status: :ok
  end

  private

  def borrow_params
    params.fetch(:borrow, {})
  end
end
