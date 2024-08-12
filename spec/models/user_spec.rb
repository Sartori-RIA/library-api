# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe '#validates' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to define_enum_for(:role).with_values(member: 0, librarian: 1) }
  end

  describe '#associations' do
    it { is_expected.to have_many(:borrows).dependent(:restrict_with_error) }

    it { is_expected.to have_many(:books).through(:borrows) }
  end
end
