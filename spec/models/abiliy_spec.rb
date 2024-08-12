# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ability, type: :ability do
  let(:librarian) { create(:user, role: :librarian) }
  let(:user) { create(:user, role: :member) }

  describe 'abilities' do
    context 'when is a librarian' do
      subject { described_class.new(librarian) }

      context 'can' do
        it { is_expected.to be_able_to(:manage, User.new(id: librarian.id)) }
        it { is_expected.to be_able_to(:manage, Book.new) }
        it { is_expected.to be_able_to(:manage, Borrow.new) }
        it { is_expected.to be_able_to(:total_books, :dashboard) }
        it { is_expected.to be_able_to(:total_borrowed_books, :dashboard) }
        it { is_expected.to be_able_to(:books_due_today, :dashboard) }
        it { is_expected.to be_able_to(:overdue_books, :dashboard) }
        it { is_expected.to be_able_to(:due_dates, :dashboard) }
      end
    end

    context 'when is a member' do
      subject { described_class.new(user) }

      context 'can' do
        it { is_expected.to be_able_to(:manage, User.new(id: user.id)) }
        it { is_expected.to be_able_to(:read, Book.new) }
        it { is_expected.to be_able_to(:read, Borrow.new(user_id: user.id)) }
        it { is_expected.to be_able_to(:books_borrowed, :dashboard) }
        it { is_expected.to be_able_to(:due_dates, :dashboard) }
      end

      context 'cannot' do
        it { is_expected.not_to be_able_to(:manage, Book.new) }
        it { is_expected.not_to be_able_to(:manage, Borrow.new) }
      end
    end
  end
end
