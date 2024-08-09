# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      load_and_authorize_resource

      # GET /books
      def index
        @books = Book.search(params[:q], fields: Book::FIELDS_TO_SEARCH) if params[:q].present?
        render json: @books
      end

      # GET /books/1
      def show
        render json: @book
      end

      # POST /books
      def create
        @book = Book.new(book_params)

        if @book.save
          render json: @book, status: :created, location: @book
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /books/1
      def update
        if @book.update(book_params)
          render json: @book
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
  end
end
