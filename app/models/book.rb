# frozen_string_literal: true

class Book < ApplicationRecord
  searchkick callbacks: :async

  FIELDS_TO_SEARCH = [:title, :author, :genre].freeze

  validates :title, :author, :genre, :isbn, :total_copies, presence: true
  validates :total_copies, numericality: { only_integer: true, greater_than: 0 }
end
