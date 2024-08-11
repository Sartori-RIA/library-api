# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  apipie
  devise_for :users, path: 'auth'

  get 'home/index'
  root "home#index"
  get '/dashboard' => 'dashboard#index'
  resources :books
  resources :borrows

  namespace :api do
    devise_for :users,
               path: 'auth',
               defaults: { format: :json },
               controllers: {
                 sessions: 'api/sessions',
                 registrations: 'api/registrations'
               }
    namespace :v1 do
      resources :books
      resources :borrows, except: [:destroy]
      resources :dashboard, only: [] do
        collection do
          get :total_books
          get :total_borrowed_books
          get :books_due_today
          get :overdue_books
          get :due_dates
          get :books_borrowed
        end
      end
    end
  end
end
