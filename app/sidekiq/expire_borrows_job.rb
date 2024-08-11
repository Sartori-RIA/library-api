# frozen_string_literal: true

class ExpireBorrowsJob
  include Sidekiq::Job

  def perform(*args)
    Borrow.to_expire.update_all(status: :expired)
  end
end
