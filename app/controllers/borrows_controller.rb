# frozen_string_literal: true

class BorrowsController < ApplicationController
  load_and_authorize_resource

  def index
    @pagy, @borrows = pagy(@borrows)
  end

  def show; end

  def new
    @books = Book.all
    @users = User.all
  end

  def edit; end

  def create
    @borrow = Borrow.new(create_params)

    if @borrow.save
      redirect_to @borrow, notice: t('flash.models.borrow.created'), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @borrow.update(update_params)
      redirect_to @borrow, notice: t('flash.models.borrow.updated'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @borrow.destroy!
    redirect_to borrows_url, notice: t('flash.models.borrow.deleted'), status: :ok
  end

  private

  def create_params
    params.require(:borrow).permit(:book_id, :user_id)
  end

  def update_params
    params.require(:borrow).permit(:status)
  end
end
