# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :request do
  let(:member_user) { create(:user, role: :member) }
  let(:librarian_user) { create(:user, role: :librarian) }
  let(:member_headers) { auth_header(member_user) }
  let(:librarian_headers) { auth_header(librarian_user) }
  let(:invalid_attributes) { { title: '' } }
  let!(:book) { create(:book) }

  describe 'GET /index' do
    context 'when is a librarian' do
      it 'renders a successful response' do
        get api_v1_books_url, headers: librarian_headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end
    context 'when is a member' do
      it 'renders a successful response' do
        get api_v1_books_url, headers: member_headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /show' do
    context 'when is a librarian' do
      it 'renders a successful response' do
        get api_v1_book_url(book), as: :json, headers: librarian_headers
        expect(response).to have_http_status(:ok)
      end
    end
    context 'when is a librarian' do
      it 'renders a successful response' do
        get api_v1_book_url(book), as: :json, headers: librarian_headers
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /create' do
    context 'when is a member' do
      it 'cannot create a book' do
        post api_v1_books_url(book), params: { book: attributes_for(:book) }, headers: member_headers, as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
    context 'with valid parameters' do
      it 'creates a new Book' do
        expect do
          post api_v1_books_url,
               params: { book: attributes_for(:book) }, headers: librarian_headers, as: :json
        end.to change(Book, :count).by(1)
      end

      it 'renders a JSON response with the new book' do
        post api_v1_books_url,
             params: { book: attributes_for(:book) }, headers: librarian_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Book' do
        expect do
          post api_v1_books_url,
               params: { book: invalid_attributes }, as: :json, headers: librarian_headers
        end.not_to change(Book, :count)
      end

      it 'renders a JSON response with errors for the new book' do
        post api_v1_books_url,
             params: { book: invalid_attributes }, headers: librarian_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'when is a member' do
      it 'cannot update a book' do
        patch api_v1_book_url(book), params: { book: attributes_for(:book) }, headers: member_headers, as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:book) }
      it 'updates the requested book' do
        patch api_v1_book_url(book),
              params: { book: new_attributes }, headers: librarian_headers, as: :json
        book.reload
        expect(book.title).to eq new_attributes[:title]
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the book' do
        patch api_v1_book_url(book),
              params: { book: invalid_attributes }, headers: librarian_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested book' do
      expect do
        delete api_v1_book_url(book), headers: librarian_headers, as: :json
      end.to change(Book, :count).by(-1)
    end
  end
end
