# frozen_string_literal: true

class Borrow < ApplicationRecord
  belongs_to :book, optional: false
  belongs_to :user, optional: false

  before_create :set_end_date

  validate :check_availability?, on: :create
  validate :check_already_borrowed?, on: :create

  enum status: { on_date: 0, returned: 1, expired: 2 }, _default: 0

  scope :due_today, -> { where(end_date: DateTime.now.all_day).order(end_date: :desc, status: :desc) }

  scope :overdue, -> { where(status: :expired) }

  scope :librarian_due_dates, lambda {
    where('end_date >= ? OR status = 2', DateTime.now.beginning_of_day)
      .order(end_date: :desc, status: :desc)
  }

  scope :member_due_dates, lambda { |user_id|
    where(user_id:).where.not(end_date: DateTime.now.beginning_of_day).order(end_date: :desc, status: :desc)
  }

  scope :total_borrowed, -> { where(status: %i[on_date expired]).count }

  scope :to_expire, -> { where(end_date: ...DateTime.now.beginning_of_day).where(status: :on_date) }

  private

  def set_end_date
    self.end_date = 2.weeks.from_now
  end

  def check_availability?
    copies = book&.total_copies.presence || 0
    not_available = Borrow.joins(:book).where(book:, status: %i[on_date expired]).count
    copies > not_available
  end

  def check_already_borrowed?
    Borrow.joins(:book, :user).where(user:, book:, status: %i[on_date expired]).any?
  end
end
