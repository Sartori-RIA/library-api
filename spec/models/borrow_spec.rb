# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Borrow do
  describe '#associations' do
    it { is_expected.to belong_to(:book).required }

    it { is_expected.to belong_to(:user).required }
  end

  describe '#validates' do
    it { is_expected.to define_enum_for(:status).with_values(on_date: 0, returned: 1, expired: 2) }

    it '#check_availability?' do
    end

    it '#check_already_borrowed?' do
    end
  end

  describe '#scopes' do
    it 'due_today' do
    end

    it 'overdue' do
    end

    it 'librarian_due_dates' do
    end

    it 'member_due_dates' do
    end

    it 'total_borrowed' do
    end
  end
end
