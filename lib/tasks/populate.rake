# frozen_string_literal: true

namespace :db do
  desc 'Erase and Fill database'
  task populate: :environment do
    [Borrow, Book].each(&:delete_all)

    # create 100 users
    100.times do
      isbn = Faker::Code.isbn(base: 13).gsub('-', '')
      book = Book.new(
        title: Faker::Book.title,
        author: Faker::Book.author,
        genre: Faker::Book.genre,
        total_copies: rand(1..10),
        isbn: isbn
      )
      unless book.save
        puts isbn
        puts book.errors.full_messages
      end
    end

    # create 10 users
    10.times do
      name = Faker::Name.name
      email = Faker::Internet.email(name:)
      User.create_with(name:, password: '123456').find_or_create_by(email:)
    end

    # create 20 borrows
    60.times do
      user = User.all.sample
      book = Book.all.sample
      Borrow.where(user:, book:, status: Borrow.statuses.sample.key).first_or_create
    end

    [
      Book
    ].each(&:reindex)
  end
end
