# frozen_string_literal: true

class DashboardController < ApplicationController
  authorize_resource class: false

  def index
    authorize! :index, :dashboard
    set_total_books
    set_total_borrowed_books
    set_books_due_today
    set_overdue_books
    set_due_dates
    set_books_borrowed
  end

  private

  def set_total_borrowed_books
    return unless can? :total_borrowed_books, :dashboard

    @total_borrowed_books = Borrow.total_borrowed
  end

  def set_total_books
    return unless can? :total_books, :dashboard

    @total_books = Book.count
  end

  def set_books_due_today
    return unless can? :books_due_today, :dashboard

    @books_due_today = Borrow.due_today
  end

  def set_overdue_books
    return unless can? :overdue_books, :dashboard

    @overdue_books = Borrow.overdue
  end

  def set_due_dates
    return unless can? :due_dates, :dashboard

    @due_dates = if current_user.librarian?
                   Borrow.librarian_due_dates
                 else
                   Borrow.member_due_dates(current_user.id)
                 end
  end

  def set_books_borrowed
    return unless can? :books_borrowed, :dashboard

    @books_borrowed = current_user.borrows
  end
end
