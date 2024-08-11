# frozen_string_literal: true

class Book < ApplicationRecord
  searchkick callbacks: :async

  FIELDS_TO_SEARCH = %i[title author genre].freeze

  validates :title, :author, :genre, :isbn, :total_copies, presence: true
  validates :total_copies, numericality: { only_integer: true, greater_than: 0 }
  validates :isbn, uniqueness: true, format: { with: /\A(\d{10}|\d{13})\z/, message: I18n.t('activerecord.errors.model.book.attributes.isbn.invalid') }

  has_many :borrows, dependent: :restrict_with_error
end
