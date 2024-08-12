# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ExpireBorrowsJob, type: :job do

  before do
    @on_date_list = create_list(:borrow, 5)
    @expired_list = create_list(:borrow, 5, :as_expired)
    Sidekiq::Testing.inline!
  end

  after do
    Sidekiq::Testing.fake!
  end

  xit 'add to the queue' do
    expect { described_class.perform_async }.to change(described_class.jobs, :size).by(1)
  end

  xdescribe 'set all expired borrows as expired' do
    it 'update the expired column to true' do
      @expired_list.each(&:reload)
      expect(@expired_list.pluck(:status).uniq).to eq ['expired']
    end
    it 'update the expired should to continue false' do
      @on_date_list.each(&:reload)
      expect(@on_date_list.pluck(:status).uniq).to include %w[returned on_date]
    end
  end
end
