# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::BorrowsController, type: :request do
  let(:member_user) { create(:user, role: :member) }
  let(:librarian_user) { create(:user, role: :librarian) }
  let(:member_headers) { auth_header(member_user) }
  let(:librarian_headers) { auth_header(librarian_user) }
  let(:invalid_attributes) { { book_id: -1 } }
  let!(:borrow) { create(:borrow) }
  let(:valid_attributes) { {
    user_id: create(:user).id,
    book_id: create(:book).id
  } }

  describe 'GET /index' do
    context 'as librarian' do
      it 'renders a successful response' do
        get api_v1_borrows_path, headers: librarian_headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end
    context 'as member' do
      it 'renders a successful response' do
        get api_v1_borrows_path, headers: member_headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /show' do
    context 'as librarian' do
      it 'renders a successful response' do
        borrow = create(:borrow)
        get api_v1_borrow_path(borrow), as: :json, headers: librarian_headers
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body[:id]).to eq borrow.id
      end
    end
    context 'as member' do
      it 'renders a successful response' do
        borrow = create(:borrow, user: member_user)
        get api_v1_borrow_path(borrow), as: :json, headers: member_headers
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body[:id]).to eq borrow.id
      end
    end
  end

  describe 'POST /create' do
    context 'when is a member' do
      it 'cannot create a borrow' do
        attr = {
          user_id: member_user.id,
          book_id: create(:book).id
        }
        post api_v1_borrows_url(borrow), params: { borrow: attr }, headers: member_headers, as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
    context 'with valid parameters' do
      it 'creates a new Borrow' do
        expect do
          post api_v1_borrows_url,
               params: { borrow: valid_attributes }, headers: librarian_headers, as: :json
        end.to change(Borrow, :count).by(1)
      end

      it 'renders a JSON response with the new borrow' do
        post api_v1_borrows_url,
             params: { borrow: valid_attributes }, headers: librarian_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Borrow' do
        expect do
          post api_v1_borrows_url,
               params: { borrow: invalid_attributes }, headers: librarian_headers, as: :json
        end.not_to change(Borrow, :count)
      end

      it 'renders a JSON response with errors for the new borrow' do
        post api_v1_borrows_url,
             params: { borrow: invalid_attributes }, headers: librarian_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'when is a member' do
      it 'cannot udate a borrow' do
        patch api_v1_borrow_url(borrow), params: { borrow: { returned: true } }, headers: member_headers, as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with valid parameters' do
      let(:new_attributes) do
        { status: :returned }
      end

      it 'updates the requested borrow' do
        borrow = create(:borrow, status: :on_date)
        patch api_v1_borrow_url(borrow), params: { borrow: new_attributes }, headers: librarian_headers, as: :json
        borrow.reload
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(borrow.status).to eq('returned')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the borrow' do
        patch api_v1_borrow_url(borrow),
              params: { borrow: { status: -1 } }, headers: librarian_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
