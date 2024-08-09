# frozen_string_literal: true

class Borrow < ApplicationRecord
  belongs_to :book, optional: false
  belongs_to :user, optional: false

  before_create :set_end_date

  validate :check_availability, on: :create

  private

  def set_end_date
    self.end_date = 2.weeks.from_now
  end

  def check_availability
    copies = book.total_copies
    not_available = Borrow.joins(:book).where(book:, returned: false).count
    copies > not_available
  end
end
