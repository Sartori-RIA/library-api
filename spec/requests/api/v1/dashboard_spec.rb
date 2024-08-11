# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DashboardController, type: :request do
  let(:member_user) { create(:user, role: :member) }
  let(:librarian_user) { create(:user, role: :librarian) }
  let(:member_headers) { auth_header(member_user) }
  let(:librarian_headers) { auth_header(librarian_user) }

  describe '#GET total_books' do
    context 'when is a librarian' do
      it 'return the total of books' do
        list = create_list(:book, 5)
        get total_books_api_v1_dashboard_index_url, headers: librarian_headers
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq({ 'total' => list.size })
      end
    end
    context 'when is a member' do
      it 'not allow a member to access' do
        get total_books_api_v1_dashboard_index_url, headers: member_headers
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe '#GET total_borrowed_books' do
    context 'when is a librarian' do
      it 'can access successfully' do
        list = create_list(:borrow, 5, status: :on_date)
        get total_borrowed_books_api_v1_dashboard_index_url, headers: librarian_headers
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq({ 'total' => list.size })
      end
    end
  end

  describe '#GET books_due_today' do
    context 'when is a librarian' do
      it 'can access successfully' do
        get books_due_today_api_v1_dashboard_index_url, headers: librarian_headers
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when is a member' do
      it 'cannot access this endpoint' do
        get books_due_today_api_v1_dashboard_index_url, headers: member_headers
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe '#GET overdue_books' do
    context 'when is a librarian' do
      it 'can access successfully' do
        get overdue_books_api_v1_dashboard_index_url, headers: librarian_headers
        expect(response).to have_http_status(:ok)
      end
    end
    context 'when is a member' do
      it 'cannot access this endpoint' do
        get overdue_books_api_v1_dashboard_index_url, headers: member_headers
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe '#GET due_dates' do
    context 'when is a librarian' do
      it 'can access successfully' do
        get due_dates_api_v1_dashboard_index_url, headers: librarian_headers
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when is a member' do
      it 'can access successfully' do
        get due_dates_api_v1_dashboard_index_url, headers: member_headers
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#books_borrowed' do
    context 'when is a librarian' do
      it 'cannot access this endpoint' do
        get books_borrowed_api_v1_dashboard_index_url, headers: librarian_headers
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when is a member' do
      it 'can access successfully' do
        get books_borrowed_api_v1_dashboard_index_url, headers: member_headers
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
