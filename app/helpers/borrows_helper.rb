# frozen_string_literal: true

module BorrowsHelper
  def badge(borrow)
    badges = {
      'on_date' => 'badge text-bg-primary',
      'returned' => 'badge text-bg-success',
      'expired' => 'badge text-bg-warning'
    }
    badges[borrow.status]
  end
end
