# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.admin?
      can :manage, :all
      can :manage, Partner
    else
      can :read, User, id: user.id
      can :update, User, id: user.id
    end
  end
end
