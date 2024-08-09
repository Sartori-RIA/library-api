# frozen_string_literal: true

class Borrow < ApplicationRecord
  belongs_to :book, optional: false
  belongs_to :user, optional: false

  before_create :set_end_date

  validate :check_availability?, on: :create
  validate :check_already_borrowed?, on: :create

  scope :due_today, -> { where(end_date: DateTime.now.all_day).order(end_date: :desc, expired: :desc) }

  scope :overdue, -> { where(returned: false, expired: false) }

  scope :librarian_due_dates, lambda {
    where('end_date >= ? OR (expired = TRUE AND returned = FALSE)', DateTime.now.beginning_of_day)
      .order(end_date: :desc, expired: :desc)
  }

  scope :member_due_dates, lambda { |user_id|
    where(user_id:).where.not(end_date: today.beginning_of_day).order(end_date: :desc, expired: :desc)
  }

  scope :total_borrowed, -> { where(returned: false).count }

  private

  def set_end_date
    self.end_date = 2.weeks.from_now
  end

  def check_availability?
    copies = book.total_copies
    not_available = Borrow.joins(:book).where(book:, returned: false).count
    copies > not_available
  end

  def check_already_borrowed?
    Borrow.joins(:book, :user).where(user:, book:, returned: false).any?
  end
end
