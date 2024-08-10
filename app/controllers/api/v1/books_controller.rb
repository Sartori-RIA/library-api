# frozen_string_literal: true

class Api::V1::BooksController < ApplicationController
  load_and_authorize_resource

  def_param_group :book do
    param :book, Hash, action_aware: true do
      param :title, String, required: true
      param :author, String, required: true
      param :genre, String, required: true
      param :total_copies, Integer, required: true
      param :isbn, String, required: true
    end
  end

  api :GET, '/api/v1/users', 'Retrieves Books from DB'
  format 'json'
  error code: 401, desc: 'You need to Sign-In first'
  error code: 403, desc: 'You\'re not allow to access here'
  error code: 404, desc: 'Not Found'
  error code: 422, desc: 'Unprocessable Entity'
  param :q, String, required: false, desc: 'Search the book by title, author, genre', allow_nil: true, allow_blank: true
  param :page, Hash do
    param :number, Integer, required: false, desc: 'Page Number'
    param :size, Integer, required: false, desc: 'Page Size, default 20'
  end
  returns array_of: :book
  def index
    @books = Book.search(params[:q], fields: Book::FIELDS_TO_SEARCH) if params[:q].present?
    pagy_render(@books)
  end

  # GET /books/1
  def show
    render json: @book, status: :ok
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      render json: @book, status: :ok
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy!
  end

  private

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :author, :genre, :isbn, :total_copies)
  end
end
