# frozen_string_literal: true

class BooksController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def new; end

  def edit; end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: t('flash.models.book.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: t('flash.models.book.updated'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy!
    redirect_to books_url, notice: t('flash.models.book.deleted'), status: :see_other
  end

  private

  def book_params
    params.fetch(:book, {})
  end
end
