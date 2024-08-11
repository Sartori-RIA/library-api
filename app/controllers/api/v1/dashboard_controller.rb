# frozen_string_literal: true

class Api::V1::DashboardController < ApplicationController
  authorize_resource class: false

  api!
  def total_books
    authorize! :total_books, :dashboard
    @total = Book.count
    render json: { total: @total }, status: :ok
  end

  api!
  def total_borrowed_books
    authorize! :total_borrowed_books, :dashboard
    @total = Borrow.total_borrowed
    render json: { total: @total }, status: :ok
  end

  api!
  def books_due_today
    authorize! :books_due_today, :dashboard
    @borrows = Borrow.due_today
    render json: @borrows, status: :ok
  end

  api!
  def overdue_books
    authorize! :overdue_books, :dashboard
    @borrows = Borrow.overdue
    render json: @borrows, status: :ok
  end

  api!
  def due_dates
    authorize! :due_dates, :dashboard
    @borrows = if current_user.librarian?
                 Borrow.librarian_due_dates
               else
                 Borrow.member_due_dates(current_user.id)
               end
    render json: @borrows
  end

  api!
  def books_borrowed
    authorize! :books_borrowed, :dashboard
    @books = current_user.books
    render json: @books, status: :ok
  end
end
