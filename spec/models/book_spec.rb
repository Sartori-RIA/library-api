# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book do
  describe '#associations' do
    it { is_expected.to have_many(:borrows).dependent(:restrict_with_error) }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:title) }

    it { is_expected.to validate_presence_of(:author) }

    it { is_expected.to validate_presence_of(:genre) }

    it { is_expected.to validate_presence_of(:isbn) }

    it { is_expected.to validate_presence_of(:total_copies) }

    it { is_expected.to validate_numericality_of(:total_copies).only_integer.is_greater_than(0) }

    it { is_expected.to allow_value('1234567890', '1234567890123').for(:isbn) }

    it {
      is_expected.to_not allow_value('123', 'abc1234567', '12345678901', '12345678901234')
                       .for(:isbn)
                       .with_message(I18n.t('activerecord.errors.model.book.attributes.isbn.invalid'))
    }
  end
end
