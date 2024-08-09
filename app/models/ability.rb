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
    else
      can :index, Book
      can :index, Borrow, user_id: user.id
    end
  end
end
