# frozen_string_literal: true

class Ability
  include CanCan::Ability

  # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  def initialize(user)
    return if user.blank?

    can :manage, User, id: user.id
    if user.librarian?
      can :manage, Book
      can :manage, Borrow
      can :total_books, :dashboard
      can :total_borrowed_books, :dashboard
      can :books_due_today, :dashboard
      can :overdue_books, :dashboard
    elsif user.member?
      can :index, Book
      can :index, Borrow, user_id: user.id
      can :books_borrowed, :dashboard
      can :due_dates, :dashboard
    end
  end
end
